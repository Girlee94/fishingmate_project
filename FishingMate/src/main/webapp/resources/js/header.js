/**
 * 
 */
 
 function moveHome(){
 	location.href = "/fishingmate/main/index.do";
 }	
 
 function highlightButton(aaa) {
	aaa.setAttribute("class", "bg-dark nav-link d-grid");
	aaa.setAttribute("style", "color: white;");
}

function unHighlightButton(aaa) {
	aaa.setAttribute("class", "nav-link d-grid");
	aaa.setAttribute("style", "color: black;");
}

function visibleMenu(aaa) {
	aaa.setAttribute("class", "bg-dark d-grid");
	aaa.children[0].setAttribute("style", "color: white;");
	aaa.children[1].setAttribute("style", "display: block; background-color: white;");
}
function inVisibleMenu(aaa) {
	aaa.removeAttribute("class");
	aaa.children[0].setAttribute("style", "color: black;");
	aaa.children[1].setAttribute("style", "display: none; background-color: white;");
}