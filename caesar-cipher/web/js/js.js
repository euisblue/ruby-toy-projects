'use strict';
let encodeTextArea = document.querySelector('#encode-textarea');
let caesarTextArea = document.querySelector('#caesar-textarea');
let shiftArea = document.querySelector('#shift');

function validate(reverse) {
	console.log(reverse);
	let shift = Number(shiftArea.value);

	if(shift == NaN || shift == undefined)
		shift = 1;

	let text = (reverse==false) ? encodeTextArea.value : caesarTextArea.value;

	console.log("text: " + text);
	let caesar = "";
	let re = /\W/;
	let SIZE = text.length;

	let code = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

	for(let i=0; i<SIZE; ++i) {
		if(re.exec(text[i]) != null) {
			caesar += text[i];
			continue;
		}

		let ascii = text[i].charCodeAt(0) - 65;

		if(reverse == false) {
			/* lower case */
			if(ascii >= 32) {
				ascii -= 32;
				ascii = 26 + ((ascii + shift) % 26);
			}
			/* upper case */
			else {
				ascii = (ascii + shift) % 26;
			}
		} else {
			if(ascii >= 32) {
				ascii -= 32;
				ascii -= shift;
				if(ascii<25) { ascii = 51 - (25-ascii); }
				else { ascii += 26; }
			}
			else {
				ascii -= shift;
				if(ascii<0) { ascii = 26 + ascii; }
			}
		}

		caesar += code[ascii];
	}

	if(reverse) {
		encodeTextArea.value = caesar;
	} else {
		caesarTextArea.value = caesar;
	}

	console.log("caesar: " + caesar);
}

encodeTextArea.addEventListener("keyup", function() {
	let	decode = false;
	validate(decode);
});
caesarTextArea.addEventListener("keyup", function() {
	let decode = true;
	validate(decode);
});

document.querySelector('#uparrow').addEventListener('click', function() {
	shiftArea.value = Number(shiftArea.value) + 1;
	validate(false);
});

document.querySelector('#downarrow').addEventListener('click', function() {
	shiftArea.value = Number(shiftArea.value) - 1;
	validate(false);
});
