 var newWindow= "";
function displayPhoto(largPhoto, thumbPhoto) {
  if (newWindow == "" || newWindow.closed) {
    newWindow = window.open("","","status,height=480,width=640,resizable")
    newWindow.name="photo";
	}
  // assemble content for new window
    var newContent = "<HTML><HEAD><TITLE>Photo</TITLE></HEAD>";
    newContent += "<img src='images/"+largePhoto+"' lowres="+thumbPhoto+"></BODY></HTML>";
  // write HTML to new window document
    newWindow.document.write(newContent);
    newWindow.document.close(); // close layout stream
  newWindow.focus();
}

