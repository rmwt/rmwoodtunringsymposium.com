function rot13(a) {
  return a.replace(/[a-zA-Z]/g, function(c){
    return String.fromCharCode((c <= "Z" ? 90 : 122) >= (c = c.charCodeAt(0) + 13) ? c : c - 26);
  })
};
window.onload = function() {
  var l = document.getElementsByClassName('email-link');
  var i;
  for (i = 0; i < l.length; i++) {
    var a = rot13(l[i].firstChild.nodeValue);
    var s = l[i].getAttribute('x-subj');
    var ss = '';
    if (s) ss = '?subject=' + s;
    var n = l[i].getAttribute('x-name');
    var nn = a;
    if (n) nn = '"'+n+'"<'+a+'>'
    var mt = rot13("znvygb:");
    l[i].setAttribute("href", mt+nn+ss);
    l[i].firstChild.nodeValue = a;
  }
};
