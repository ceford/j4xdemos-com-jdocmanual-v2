
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
 * click on an item in the 'In this page' column to scroll into view
 */
function scrolltoheading() {
  document.querySelectorAll("#scroll-panel h2, #scroll-panel h3")[this.getAttribute('data-index')].scrollIntoView(
  {
    behavior: 'smooth', block: 'center'
  });
}

/**
 * Set the page content by clicking a page item in the index
 */
let contents = document.getElementsByClassName("content-link");

let getPage = function() {
  let link_id = this.getAttribute('data-content-id');
  setPanelContent(link_id, this.innerText);
};

for (let i = 0; i < contents.length; i += 1) {
  contents[i].addEventListener('click', getPage, false);
}

/**
 * fetch the page from source, display in centre and create 'In this page'
 */
async function setPanelContent(itemId, title) {
  let document_title = document.getElementById('document-title');
  if (!document_title) {
    return;
  }
  let document_panel = document.getElementById('document-panel');
  //let main_panel = document.getElementById('jdocmanual-main');
  document_panel.innerHTML = `<div class="text-center">
    <div class="spinner-border m-5" role="status">
      <span class="sr-only">Loading...</span>
    </div>
  </div>`;
  let jdocmanual_original = document.getElementById('select-actions-children-preview');
  let page_path = document.getElementById('jform_page_path');
  page_path.value = itemId;

  setCookie('jdocmanualItemId', itemId, 10);
  setCookie('jdocmanualTitle', title, 10);

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
  data.append('manual', manualId);
  data.append('item_id', itemId);
  data.append('page_language_code', lang);
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

    document_title.innerText = title;
    document_panel.innerHTML = result;

    // jdocmanual_active_url is javascript in the page at load time
    if (jdocmanual_original) {
      // create the link for the Original button and show it
      if (jform_page_language_code && jform_page_language_code.value !== 'en') {
        lang = '/' + jform_page_language_code.value;
      }
      let source_url = document.getElementById('jform_index_url').value;
      source_url = source_url.substring(0, source_url.lastIndexOf('/') + 1);
      jdocmanual_original.href = source_url + itemId + lang;
      jdocmanual_original.classList.remove('d-none');
    }

    // create the Table of Contents
    if(document.querySelectorAll("#scroll-panel h2, #scroll-panel h3").length > 0) {
      let html = '<div class="h3 mt-3">' + Joomla.Text._('COM_JDOCMANUAL_JDOCMANUAL_TOC_IN_THIS_PAGE') + '</div><ul>';
      document.querySelectorAll("#scroll-panel h2, #scroll-panel h3").forEach(function(element) {
        html += '<li class="toc-link toc-link-' + element.localName + '">' + element.textContent + '</li>';
      });
      html += '</ul>';
      document.querySelector("#toc-panel").innerHTML = html;
      /* toc */
      document.querySelectorAll(".toc-link").forEach(function(element, index) {
        element.setAttribute('data-index', index);
        element.addEventListener('click', scrolltoheading, false);
      });
    }
    // scroll the content area to the first heading on content load
    document.querySelectorAll(".toc-link")[0].click();
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

