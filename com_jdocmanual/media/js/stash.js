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
			task.value = 'gfmfile.commit';
			form.submit();
			return true;
		}
		return false;
	}
}

