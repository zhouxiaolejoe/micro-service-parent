var REQ_URL ='http://121.36.148.182:32719';
function getURL(){
    var htmlobj=$.ajax({url:"/pushdata/file/url.txt",async:false});
    var temp=htmlobj.responseText;
    REQ_URL= temp;
}

