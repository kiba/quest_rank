function metadata(error,data)
{
  if (error) { alert(error);}
  $("#title").text(data.title);
  var result = "Authors: "
  for (var i= 0;i < data.authors.length;i ++)
  {
    result += data.authors[i] + ", ";
  }
  result = result.slice(0, -2);
  $("#authors").text(result);
  $("#description").text(data.description);
  $("#link").html("<a href=\"" + data.url +"\">" + "Link" + "</a>");
}
