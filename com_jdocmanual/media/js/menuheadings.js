/**
 * Used in the Menu Headings page to update Display Title.
 */
let fixheading = document.getElementsByClassName('fix-heading');
if (fixheading) {
	for (let i = 0; i < fixheading.length; i++) {
		fixheading[i].addEventListener('change', fixer, false);
	}
}

async function fixer(event) {
	event.preventDefault();
	let tds = document.querySelectorAll('td.update-ok');
	tds && tds.forEach(function (item, index) {
		item.classList.remove('update-ok');
	});
	tds = document.querySelectorAll('td.update-dud');
	tds && tds.forEach(function (item, index) {
		item.classList.remove('update-dud');
	});
	let id = this.id;
	let parts = id.split('_');
	let td = this.closest('td');
	let value = this.value;
	let original_id = this.getAttribute('data-original_id');
	let language = this.getAttribute('data-filter_language');
	const token = Joomla.getOptions('csrf.token', '');
	const url = 'index.php?option=com_jdocmanual&task=menuheadings.update&' + token + '=1';
	let data = new URLSearchParams();
	data.append(`field`, parts[0]);
	data.append(`item_id`, parts[1]);
	data.append(`value`, value);
	data.append(`original_id`, original_id);
	data.append(`language`, language);
	const options = {
		method: 'POST',
		body: data
	}
	let response = await fetch(url, options);
	if (!response.ok) {
		td.classList.add('update-dud');
		throw new Error (Joomla.Text._('COM_JDOCMANUAL_JS_ERROR_STATUS') + `${response.status}`);
	} else {
		let result = await response.text();
		if (result.includes('NOT OK')) {
			td.classList.add('update-dud');
			alert (result);
		} else {
			td.classList.add('update-ok');
			if (result.includes('OK 1')) {
				// Normal update of existing item.
			}
			if (result.includes('OK 2')) {
				// New item created.
				parts = result.split(':')
				this.setAttribute('id', 'heading_' + parts[1]);
			}
		}
	}
}