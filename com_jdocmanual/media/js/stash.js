/**
 * For a new article, create the jdoc_key and filename from the Display title
 */

let pageid = document.getElementById('jform_page_id');
if (pageid) {
    let displaytitle = document.getElementById('jform_display_title');
    let jdockey = document.getElementById('jform_jdoc_key');
    let filename = document.getElementById('jform_filename');
    let heading = document.getElementById('jform_heading');

    displaytitle.addEventListener('change', function() {
        // Set the jdoc_key from the display title.
        displaytitle.value = displaytitle.value.trim();
        // Space replaced by underline.
        jdockey.value = displaytitle.value.replaceAll(' ', '_');
        // Lower case.
        let tmp = jdockey.value.toLowerCase();
        // Replace non alpha-numeric with dash
        tmp = tmp.replaceAll(/[^a-z0-9]/gi, '-');
        // Replace multiple dashes with one dash
        tmp = tmp.replaceAll(/-{2,}/gi, '');
        // Replace leading or ending dashes
        tmp = tmp.replace(/^-/, '');
        tmp = tmp.replace(/-$/, '');
        filename.value = tmp + '.md'
    });

    heading.addEventListener('change', function() {
        // Lower case.
        let tmp = heading.value.trim();
        tmp = tmp.toLowerCase();
        // Replace non alpha-numeric with dash
        tmp = tmp.replaceAll(/[^a-z0-9]/gi, '-');
        // Replace multiple dashes with one dash
        tmp = tmp.replaceAll(/-{2,}/gi, '');
        // Replace leading or ending dashes
        tmp = tmp.replace(/^-/, '');
        tmp = tmp.replace(/-$/, '');
        heading.value = tmp;
    });
}


/**
 * Check that there is a commit message before allowing commit.
 */

let msg = document.getElementById('jform_commit_message');
let commit = document.getElementsByClassName('button-gfm-commit');
if (commit) {
	for (let i = 0; i < commit.length; i++) {
		commit[i].addEventListener('click', committer, false);
	}
}

function committer(event) {
	// Get the length of the commit message.
	if (msg.value.length < 25) {
		alert('The Commit Message is missing or too short!');
		return false;
	} else {
		// form.submit();
		if(confirm('This action will commit and merge the changes in this PR.')) {
			let form = document.getElementById('adminForm');
			let task = document.getElementById('task');
			task.value = document.getElementById('toolbar-gfm-commit').getAttribute('task');
			form.submit();
			return true;
		}
		return false;
	}
}

