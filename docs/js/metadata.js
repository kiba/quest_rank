function metadata(error,data)
{
  if (error) { alert(error);}
  $("#title").text(data.title);
  $("#description").text(data.description);
  $("#link").html("<a href=\"" + data.url +"\">" + "Link" + "</a>");
}
