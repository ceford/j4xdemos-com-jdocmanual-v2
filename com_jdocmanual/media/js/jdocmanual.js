
/**
 * setCookie for consistent cookie handling
 * 
 */
function setCookie(name, value, days) {
  let expires = "";
  let date = new Date();
  // is the siteroot set for this template
  let paths = Joomla.getOptions(["system.paths"], "No good");
  let root = paths.root;
  const samesite = "; samesite=None; secure=true";
  let baseFull = paths.baseFull; // "http:\/\/localhost\/j4ops\/"

  if (days) {
    date.setTime(date.getTime()+(days*24*60*60*1000));
  } else {
    date.setTime(date.getTime());
  }
  expires = "; expires="+date.toGMTString();
  if (typeof root === undefined) {
    path = "; path=/";
  } else {
    path = "; path=" + root;
  }
  document.cookie = name + "=" + value + expires + path + samesite;
}

/**
 * getCookie - return cookie by name
 */
function getCookie(name) {
  let nameEQ = name + "=";
  let ca = document.cookie.split(";");
  for (let i = 0; i < ca.length; i += 1) {
    let c = ca[i];
    while (c.charAt(0) === " ") {
      c = c.substring(1,c.length);
    }
    if (c.indexOf(nameEQ) === 0) {
      return c.substring(nameEQ.length,c.length);
    }
  }
  return null;
}

/**
 * eraseCookie by name
 */
function eraseCookie(name) {
  setCookie(name,'',0);
}

/**
 * Select manual
 */

let manuals = document.getElementsByClassName('set-manual');

let setManual = function() {
  const regex = /.*manual-(\w{1,}) .*/;
  let className = this.className;
  let manual = className.match(regex)[1];
  let task = document.getElementById('task');
  task.value = 'display.selectmanual';
  let jform_manual = document.getElementById('jform_manual');
  jform_manual.value = manual;
  let form = document.getElementById('adminForm');
  form.submit();
}

for (let i = 0; i < manuals.length; i += 1) {
  manuals[i].addEventListener('click', setManual, false);
}

/**
 * Select index language or content language
 */

let languages = document.getElementsByClassName('set-language');

let setLanguage = function() {
  const regex = /.*button-(([a-z]|-){1,}) .*/;
  let className = this.className;
  let language_code = className.match(regex)[1];
  // the tasks are set in the Toolbar buttons so not really needed here
  let task = document.getElementById('task');

  let jform_index_language_code = document.getElementById('jform_index_language_code');
  let jform_page_language_code = document.getElementById('jform_page_language_code');
  if (this.classList.contains('index')) {
    jform_index_language_code.value = language_code;
    task.value = 'display.selectindexlanguage';
  } else {
    jform_page_language_code.value = language_code;
    task.value = 'display.selectpagelanguage';
  }
  let form = document.getElementById('adminForm');
  form.submit();
};

for (let i = 0; i < languages.length; i += 1) {
  languages[i].addEventListener('click', setLanguage, false);
}

/**
 * Joomla menu toggle - hide or show the Joomla menu
 */

let toggle = document.getElementById('toggle-joomla-menu');

if(toggle) {
  toggle.addEventListener('click', function() {
    let wrapper = document.getElementById('sidebar-wrapper');
    let style = getComputedStyle(wrapper);
    if (style.display === 'none') {
      wrapper.classList.remove('d-none');
    } else {
      wrapper.classList.add('d-none');
    }
  });
}

/**
 * Set the page content by clicking a page item in the index
 */
let contents = document.getElementsByClassName("content-link");

let getPage = function(event) {
  event.preventDefault();
  // this contains the full url of the link
  let url = new URL(this);
  let paramsString = url.search;
  let searchParams = new URLSearchParams(paramsString);
  link_id = searchParams.get('id');
  let jdoc_key = this.getAttribute('data-content-id');
  setPanelContent(link_id, jdoc_key, this.innerText);
  // add the highlight class from the selected index item
  this.parentElement.classList.add("gfmfile-active");
};

for (let i = 0; i < contents.length; i += 1) {
  contents[i].addEventListener('click', getPage, false);
}

/**
 * Fetch the selected page from source.
 */
async function setPanelContent(itemId, jdoc_key, title) {
  let document_title = document.getElementById('document-title');
  if (!document_title) {
    return;
  }
  //document_title.innerHTML = title;

  // remove the highlight class from the selected index item
  let index_items = document.getElementsByClassName('gfmfile-active');
  [].forEach.call(index_items, function(el) {
    el.classList.remove("gfmfile-active");
  });

  let document_panel = document.getElementById('document-panel');
  document_panel.innerHTML = `<div class="text-center">
    <div class="spinner-border m-5" role="status">
      <span class="sr-only">Loading...</span>
    </div>
  </div>`;
  let toc_panel = document.getElementById('toc-panel');

  let olink = document.getElementById('select-actions-children-preview');
  olink.href = olink.protocol + '//' + olink.host + '/' + jdoc_key;

  let menu_page_id = document.getElementById('jform_menu_page_id');
  menu_page_id.value = itemId;

  // alter the cookie {$manual}-{$index_language_code}-{$page_language_code}-{$menu_page_id}
  let cookie = getCookie('jdocmanual');
  let cookie_items = cookie.split('-');
  cookie_items.pop();
  cookie_items.push(itemId);
  cookie = cookie_items.join('-');
  setCookie('jdocmanual', cookie, 10);

  // get token from javascript loaded in the page
  const token = Joomla.getOptions('csrf.token', '');
  let manualId = document.getElementById('jform_manual').value;
  let lang = '';
  let jform_page_language_code = document.getElementById('jform_page_language_code');
  if (jform_page_language_code && jform_page_language_code.value !== 'en') {
    lang = jform_page_language_code.value;
  }
  let url = 'index.php?option=com_jdocmanual&task=content.fillpanel';
  let data = new URLSearchParams();
  data.append('item_id', itemId);
  data.append(token, 1);
  const options = {
    body: data,
    method: 'POST'
  };
  let response = await fetch(url, options);
  if (!response.ok) {
    document_panel.innerHTML = response.status;
    throw new Error (Joomla.Text._('COM_MYCOMPONENT_JS_ERROR_STATUS'));
  } else {
    let result = await response.text();
    let obj = JSON.parse(result);
    toc_panel.innerHTML = obj[0];
    document_panel.innerHTML = obj[1];
    document_title.innerHTML = obj[2];
  }
}

// the default index location - set on page load
let indexLocation = 'oncanvas';

function setIndexLocation () {
  const vw = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0);
  // if the width is less than 576 move the index off canvas
  let offcanvasId = document.getElementById('offcanvasMenu');
  let oncanvasId = document.getElementById('oncanvasMenu');
  let jdocmanulId = document.getElementById('jdocmanual-wrapper');
  if (vw < 576) {
    if (indexLocation == 'oncanvas') {
      offcanvasId.appendChild(jdocmanulId);
      indexLocation = 'offcanvas';
    }
  } else {
    if (indexLocation == 'offcanvas') {
      oncanvasId.appendChild(jdocmanulId);
      indexLocation = 'oncanvas';
    }
  }
}

/**
 * Set up after page load after change of Manual, etc
 */
/*
document.addEventListener('DOMContentLoaded', function(event) {
  // has a jdocmanualReset cookie been set
  if (getCookie('jdocmanualReset')) {
    eraseCookie('jdocmanualItemId');
    eraseCookie('jdocmanualTitle');
    eraseCookie('jdocmanualLastHeading');
  } else {
    // if cookies exist - jdocmanualItemId and jdocmanualTitle
    if (getCookie('jdocmanualItemId')) {
      let itemId = getCookie('jdocmanualItemId');
      let title = getCookie('jdocmanualTitle');
      setPanelContent(itemId, title);
    }
  }

  // remember which Index heading was open last
  let collapses = document.getElementsByClassName("accordion-collapse");
  if (collapses) {
    for (let i = 0; i < collapses.length; i += 1) {
      collapses[i].addEventListener('show.bs.collapse', saveLastHeading, false);
    }
  }

  function saveLastHeading() {
    setCookie('jdocmanualLastHeading', this.id, 10);
  }

  // open the last Index heading or the first heading
  let collapse = document.getElementById('collapse_1');
  let lastHeading = getCookie('jdocmanualLastHeading');
  if (lastHeading) {
    collapse = document.getElementById(lastHeading);
  }
  collapse && collapse.classList.add('show');

  // get the viewport width
  const vw = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0);
  // if the width is less than 576 move the index off canvas
  indexLocation = 'oncanvas';
  if(vw < 576) {
    let offcanvasId = document.getElementById('offcanvasMenu');
    let oncanvasId = document.getElementById('jdocmanual-wrapper');
    offcanvasId.appendChild(oncanvasId);
    indexLocation = 'offcanvas';
  }
  window.addEventListener("resize", setIndexLocation);
});
*/
