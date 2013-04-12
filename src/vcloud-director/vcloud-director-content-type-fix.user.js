// ==UserScript==
// @name          vCloud Director 5.1.1 Content-Type Workaround
// @version       1.0.1
// @description	  Fixes the URL /loginComplete being served without any content-type
// @author        Alexandre Mercier (pro.alexandre.mercier@gmail.com)
// @namespace     http://github.com/amercier/
// @include       https://*/loginComplete
// ==/UserScript==
// Notes:
//   * is a wildcard character
//   .tld is magic that matches all top-level domains (e.g. .com, .co.uk, .us, 

//window.onload = window.onload || function() {
	var pres = window.document.getElementsByTagName('pre');
	if(pres.length > 0) {
		console.warn('vCloud Director 5.1.1 Content-Type Workaround: replacing text with code');
		var code = window.document.getElementsByTagName('pre')[0].childNodes[0].nodeValue.replace(/.*<script[^>]*>(.*)<\/script>.*/, '$1');
		code = 'setTimeout(function() { ' + code + ' }, 50);';
		var s = document.createElement('script');
		s.innerHTML = code;
		document.body.appendChild(s);
	}
//}