function metadata(error,data)
{
  if (error) { alert(error);}
  $("#title").text(data.title);
  $("#description").text(data.description);
}
