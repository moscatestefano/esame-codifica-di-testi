	window.onload = gestoreLoad;
	const LARGHEZZA_IMMAGINE = 3200;
	var nodoImmagine;
	var nodi_span;
	var dimensione_img;
	var nodi_mappa;
	var areas;
	var nodoContenitore;
	var coordinateResize;
	var sticky;
	var stick;
	
	
function gestoreLoad() {
	try {
		nodoImmagine = document.getElementById("lettera_con_zone");
		nodoContenitore = document.getElementById("rotazione");
		dimensione_img = LARGHEZZA_IMMAGINE;
		nodi_span = document.getElementsByClassName("hotspot");
		areas = document.getElementsByTagName("area");
		coordinateResize = [];
		nodi_mappa = document.getElementsByTagName("area");
		for (var i = 0; i < nodi_mappa.length; i++) {
			nodi_mappa[i].onmouseover = gestoreCursoreIn;
			nodi_mappa[i].onmouseout = gestoreCursoreOut;
			nodi_mappa[i].onclick = gestoreClick;
			coordinateResize[i] = nodi_mappa[i].coords.split(",");
		for (var index = 0; index < areas.length; index++ ) {    
				areas[index].addEventListener( 'mouseover', function () {this.focus();}, false );
				areas[index].addEventListener( 'mouseout', function () {this.blur();}, false );
			};
		}
		for (var i = 0; i < nodi_span.length; i++) {
			nodi_span[i].onmouseover = cambiaColore;
			nodi_span[i].onmouseout = ritornaColore;
		}
		window.onresize = gestoreResize;
		gestoreResize();
		sticky = document.getElementById("sticky");
		stick = sticky.offsetTop;
		window.onscroll = function() {myFunction()};
	} catch (err) {
		alert("gestoreLoad " + err);
	}
}

function mostraNascondi(id) {
	if (document.getElementById(id).style.display == "block") {
		document.getElementById(id).style.display = "none";
	} else
		document.getElementById(id).style.display = "block";
}

function myFunction() {
  if (window.pageYOffset > stick) {
	console.log(window.pageYOffset + " finestra");
    sticky.classList.add("sticky");
	if (window.pageYOffset > 1900) {
    sticky.classList.remove("sticky");
	}
  } else {
	sticky.classList.remove("sticky");
  }
} 

	function gestoreResize() {
	try {
		var attualeDimensione = nodoImmagine.width;
		var ratio =  attualeDimensione / dimensione_img;
		for (var i = 0; i < nodi_mappa.length; i++) {
			for (var j = 0; j < coordinateResize[i].length; j++) {
				coordinateResize[i][j] *= ratio;
			}
			nodi_mappa[i].coords = coordinateResize[i].join(",");
		}
		dimensione_img = attualeDimensione;
	} catch (err) {
		alert("gestoreResize " + err);
	}
}
	

function gestoreCursoreIn() {
	try {
		this.style.cursor = "crosshair";
		var stringa = "#";
		var nuovo_id = stringa.concat(this.id);
		console.log(nuovo_id);
		if (document.getElementById(nuovo_id).style.backgroundColor == "")
			document.getElementById(nuovo_id).style.backgroundColor = "yellow";
		else
			document.getElementById(nuovo_id).style.backgroundColor = "";
	} catch (err) {
		alert("gestoreCursore " + err);
	}
}

function gestoreCursoreOut() {
	try {
		this.style.cursor = "crosshair";
		var stringa = "#";
		var nuovo_id = stringa.concat(this.id);
		console.log(nuovo_id);
		if (document.getElementById(nuovo_id).style.backgroundColor == "")
			document.getElementById(nuovo_id).style.backgroundColor = "yellow";
		else
			document.getElementById(nuovo_id).style.backgroundColor = "";
	} catch (err) {
		alert("gestoreCursore " + err);
	}
}

function gestoreClick() {
	try {
		var stringa = "#";
		var nuovo_id = stringa.concat(this.id);
		console.log(nuovo_id);
		console.log("qui");
		if (document.getElementById(nuovo_id).style.backgroundColor == "")
			document.getElementById(nuovo_id).style.backgroundColor = "yellow";
		else
			document.getElementById(nuovo_id).style.backgroundColor = "";
	} catch (err) {
		alert("gestoreCursore " + err);
	}
}

function ruota() {
	var orient = nodoContenitore.getAttribute("style");
	if (orient == "transform:rotate(0deg)") {
		nodoContenitore.setAttribute("style", "transform:rotate(90deg)");
	}
	else if (orient == "transform:rotate(90deg)")
		nodoContenitore.setAttribute("style", "transform:rotate(180deg)");
	else if (orient == "transform:rotate(180deg)")
		nodoContenitore.setAttribute("style", "transform:rotate(270deg)");
	else if (orient == "transform:rotate(270deg)")
		nodoContenitore.setAttribute("style", "transform:rotate(0deg)");
}

function cambiaColore() {
	this.style.cursor = "crosshair";
	this.style.backgroundColor = "yellow";
	var n = this.getAttribute("n");
	areas[n-1].focus();
}

function ritornaColore() {
	this.style.backgroundColor = "";
	var n = this.getAttribute("n");
	areas[n-1].blur();
}

function disattiva() {
	var collezione = document.getElementsByClassName("img-magnifier-glass")
	for (i = 0; i < collezione.length; i++)
		collezione[i].style.visibility = "hidden";
}

function magnify(imgID, zoom) {
  var img, glass, w, h, bw;
  img = document.getElementById(imgID);

  glass = document.createElement("DIV");
  glass.setAttribute("class", "img-magnifier-glass");

  img.parentElement.insertBefore(glass, img);

  glass.style.backgroundImage = "url('" + img.src + "')";
  glass.style.backgroundRepeat = "no-repeat";
  glass.style.backgroundSize = (img.width * zoom) + "px " + (img.height * zoom) + "px";
  bw = 3;
  w = glass.offsetWidth / 2;
  h = glass.offsetHeight / 2;

  glass.addEventListener("mousemove", moveMagnifier);
  img.addEventListener("mousemove", moveMagnifier);

  glass.addEventListener("touchmove", moveMagnifier);
  img.addEventListener("touchmove", moveMagnifier);
  function moveMagnifier(e) {
    var pos, x, y;
    e.preventDefault();
    pos = getCursorPos(e);
    x = pos.x;
    y = pos.y;
    if (x > img.width - (w / zoom)) {x = img.width - (w / zoom);}
    if (x < w / zoom) {x = w / zoom;}
    if (y > img.height - (h / zoom)) {y = img.height - (h / zoom);}
    if (y < h / zoom) {y = h / zoom;}
    glass.style.left = (x - w) + "px";
    glass.style.top = (y - h) + "px";
    glass.style.backgroundPosition = "-" + ((x * zoom) - w + bw) + "px -" + ((y * zoom) - h + bw) + "px";
  }

  function getCursorPos(e) {
    var a, x = 0, y = 0;
    e = e || window.event;
    a = img.getBoundingClientRect();
    x = e.pageX - a.left;
    y = e.pageY - a.top;
    x = x - window.pageXOffset;
    y = y - window.pageYOffset;
    return {x : x, y : y};
  }
}