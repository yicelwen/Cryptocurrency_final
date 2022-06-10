<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="../backendNavBar.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script src="${contextRoot}/javascripts/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${contextRoot}/css/bootstrap.min.css">
<link rel="stylesheet" href="${contextRoot}/css/article.css">
<script src="https://kit.fontawesome.com/0ef2a35b44.js" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>${Article.title}</title>
</head>
<body>
<div class="container mb-5 mt-5">
    <div class="card article-section table-article">
        <div class="card-header">
            <h3>${Article.title}</h3>
            <input id="aid" type="hidden" value="${Article.id}"/>
            <input id="articleId" type="hidden" value="${Article.id}"/>
            <input id="authorid" type="hidden" value="${Article.authorId}"/>
            <input id="atcAdded" type="hidden" value="${Article.added}" />
            <span class="editFunction">
                <a href="${contextRoot}/editArticleAdmin/${Article.id}"><i class="fa fa-edit" aria-hidden="true"></i>Edit</a>
                <a href="${contextRoot}/deleteArticleAdmin/${Article.id}" onclick="return confirm('確認刪除嗎?')"><i class="fa fa-trash-o" aria-hidden="true"></i>Delete</a>
            </span>
            <div class="d-flex justify-content-between divToGetImg">
                <div class="d-flex">                        
                    <img class="mr-3 rounded-circle" style="display:block; width:56px; height:56px" src="data:image/gif;base64,${img}"/>
                    <div class="d-flex flex-column">
                        <span class="name"><h5>${userName}</h5></span>
                        <span class="date text-black-50" id="added"></span>
                    </div>
                </div>
                <div>
                    <img class="tagImg" src="${contextRoot}/images/currencyIcon/${Article.tag}.png" alt="">${Article.tag}
                </div>
            </div>
            <div style="align-items: center;background-color: #dbf8ff;" class="mt-2 mb-2">
                <pre id="article-content">${Article.text}</pre>
            </div>
            <div class="m-1">                 
                <span id="goodsSection"><label><input type="checkbox" class="check"><span class="heart"><i class="fa-solid fa-heart"></i></span></label>${Article.goodNum}</span>  
                <!-- <button id="doComment" class="btn btn-primary btn-sm shadow-none">Comment</button> -->
            </div>
            <!-- <div id="respond">
                <div class="comment-l bg-light p-2" style="display: none;">
                    <div class="d-flex flex-row align-items-start divToGetImg">
                        <img class="rounded-circle" src="data:image/gif;base64,${memImg}" width="40">
                        <textarea class="form-control ml-1 shadow-none textarea" id="text-c" tabindex="1" placeholder="我其實也不是一定要評論"  style="resize:none;width:600px;height:90px;">我其實也不是一定要評論</textarea>
                    </div>
                    <div class="mt-2 text-right">
                        <button class="btn btn-primary btn-sm shadow-none" type="button" id="submit-c" tabindex="2">Post comment</button>
                        <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" type="button" id="closeComment">Cancel</button>
                    </div>
                </div> -->
                <!-- <ul class="comment-r" style="display: none;">
                    <li>
                        <label for="userName">Name:(necessery)</label>
                    </li>
                    <li>
                        <input type="text" id="userName-c" size="25" tabindex="2" aria-required='true' value="${login.customizedUserName}"/>
                    </li>
                    <li>
                        <label for="userEmail">E-mail:(necessery)</label>
                    </li>
                    <li>
                        
                        <input type="hidden" id="userId" value="${login.id}" />
                    </li>
                    <li>
                        <input type="text" id="userEmail-c" size="25" tabindex="3" aria-required='true' value="${login.eMail}"/>
                    </li>                            
                </ul>
            </div> -->
        </div>
        <div class="card-body viewAtc">
                <div class="row section_title">
                    <div class="col-md-12" id="comment-list">
                    </div>
                </div>
                <nav aria-label="Page navigation example">
                    <ul class="pagination" id="pageidC">
                    </ul>
                </nav>
        </div>
    </div>
</div>
<script type="text/javascript">
var page = 1;
let commDataNow = {};
let replyDataNow = {};
getAtcTime();
loadComment();
// verifyMembershipOnload();
// $("#submit-c").click(function(){comment()})
// doComment.addEventListener('click',verifyMembership);
// closeComment.addEventListener('click',closeCommentL);

// function verifyMembershipOnload(){
//     if ("${Article.authorId}" == "${login.id}") {
//         $(".editFunction").show()
//     }
// }

// function verifyMembership(){
//     if ("${login == null }" == "true") {
//         $('#loginModal').modal("show")
//     }else{
//         $(".comment-l").show();        
//         $("#doComment").hide();
//     }
// }

// function closeCommentL(){
//     $(".comment-l").hide();
//     $("#doComment").show();    
// }

function closeEditForm(){
    $(".editForm").empty();
    $(".reply-section").hide();
}

// async function comment(){
//     await commentTo();
//     await wait(100);
//     loadComment();
//     $(".comment-l").hide();
//     $("#doComment").show(); 
// }

async function wait(ms) {
    console.log('ok')
    return new Promise(resolve => {
      setTimeout(resolve, ms);
    });
}

// async function reply(id){
//     await replyTo(id);
//     await wait(100);
//     loadReply(id);
//     $("#replySection"+id).hide()
// }

function closeReply(id){
    $("#reply-list"+id).empty();
    $("#pageidR"+id).empty();
    $("#showR"+id).show();
    $("#closeR"+id).hide();
}

// function doReply(id){
//     if ("${login == null }" == "true") {
//         $('#loginModal').modal("show")
//     }else{
//     $("#replySection"+id).show()
//     }
// }

pageidC.addEventListener('click',switchPageC);

function switchPageC(e){
    e.preventDefault();
    if(e.target.nodeName !== 'A') return;
    const page = e.target.dataset.page;
    commPagination(commDataNow, page);
}

function switchPageR(e, id){
    console.log("這裡是"+id);
    e.preventDefault();
    if(e.target.nodeName !== 'A') return;
    const page = e.target.dataset.page;
    console.log("這是第幾頁"+page);
    replyPagination(replyDataNow, page, id);
    console.log("現在的reply是"+replyDataNow);
}

// function commentTo(){
//     var userNameC = document.getElementById("userName-c").value;
//     var userEmailC = document.getElementById("userEmail-c").value;
//     var textC = document.getElementById("text-c").value;
//     var articleIdC = document.getElementById("articleId").value;
//     var userIdC = document.getElementById("userId").value;
//     var comm = {
//         "userName":userNameC,
//         "userEmail":userEmailC,
//         "text":textC,
//         "type":"a",
//         "deleted":"n",
//         "articleId":articleIdC,
//         "userId":userIdC
//     }
//     var jsonComm = JSON.stringify(comm);
//     fetch('http://localhost:8080/coinshell/doComment', {
//         // credentials: 'include',
//         method:'POST',
//         headers: {
//             'Content-Type': 'application/json'    
//         },
//         body:jsonComm    
//     }).then(res => {
//             return res.json();
//         }).then(result =>{
//             console.log(result);
//         });
// };

// function replyTo(id){
//     var userNameR = document.getElementById("userName-r"+id).value;
//     var userEmailR = document.getElementById("userEmail-r"+id).value;
//     var textR = document.getElementById("text-r"+id).value;
//     var articleIdR = document.getElementById("articleId").value; 
//     var commentIdR = document.getElementById("commentId"+id).value;
//     var userIdR = document.getElementById("userId").value;
//     var reply = {
//         "userName":userNameR,
//         "userEmail":userEmailR,
//         "text":textR,
//         "type":"b",
//         "deleted":"n",
//         "articleId":articleIdR,
//         "commentId":commentIdR,
//         "userId":userIdR
//     }
//     console.log(reply);
//     var jsonReply = JSON.stringify(reply);
//     fetch('http://localhost:8080/coinshell/doReply?commentId='+commentIdR, {
//         method:'POST',
//         headers: {
//             'Content-Type': 'application/json'    
//         },
//         body:jsonReply
//     }).catch(error => console.log('Error:', error))
//     .then(res => {
//             return res.json();
//         }).then(result =>{
//             console.log(result);
//         });
// }

function loadComment(){
    $(function() {
        var aid = document.getElementById("aid").value;
        console.log(aid);
        $("#comment-list").empty();
        fetch("http://localhost:8080/coinshell/viewCommentAdmin?articleId="+aid).then(function(response) {
            return response.json();
            console.log(response.json())
        }).then(function(data) {
            console.log(data);
            commDataNow = data;
            commPagination(data, 1)
        })
    })
}

function commPagination(array, nowPage){
    console.log("Comment傳過來是第幾頁"+nowPage);
    console.log("Comment傳過來是"+array);
    const dataTotal = array.length;
    const perpage = 5;
    const pageTotal = Math.ceil(dataTotal / perpage);
    console.log(`全部評論:`+dataTotal+` 每一頁顯示:`+perpage+`筆`);
    let currentPage = nowPage;
    if (currentPage > pageTotal) {currentPage = pageTotal;}
    const minData = (currentPage * perpage) - perpage + 1 ;
    const maxData = (currentPage * perpage) ;
    const data = [];
    array.forEach((item, index) => {
        const num = index + 1;
        if ( num >= minData && num <= maxData) {
            data.push(item);
        }
    })
    console.log(data);
    displayComm(data)
    const page = {
        pageTotal,
        currentPage,
        hasPage: currentPage > 1,
        hasNext: currentPage < pageTotal,
    } 
    console.log(page);
    pageBtn(page)
}

function getAtcTime() {
    $("#added").empty();
    var atcAdded = document.getElementById("atcAdded").value;
    console.log("時間是"+atcAdded);
    var added = new Date(Date.parse(atcAdded));
    var YYYY = added.getFullYear();
    var MM = added.getMonth()+1;
    var dd = added.getDate();
    var HH = added.getHours();
    var mm = added.getMinutes();
    var weekIndex = added.getDay();
    var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    var weekDayPrint = weekDay[weekIndex];
    $("#added").append(YYYY+`-`+MM+`-`+dd+` `+HH+`:`+mm+` `+weekDayPrint);
}

function displayComm(data){
    $("#comment-list").empty();
    $.each(data, function(index, value) {
            var added = new Date(Date.parse(value.added));
            var YYYY = added.getFullYear();
            var MM = added.getMonth()+1;
            var dd = added.getDate();
            var HH = added.getHours();
            var mm = added.getMinutes();
            var weekIndex = added.getDay();
            var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
            var weekDayPrint = weekDay[weekIndex];
            var id = value.id;
            var cidForReply = value.commentId;   
            var img = value.userAvatar;
            let deleted = value.deleted;
            let text = value.text;
            if (deleted=="y"){
                    text = `<del>`+text+`</del>`
            };
                
            $("#comment-list").append(`
                    <div class="media-body rounded">
                        <div class="row">
                            <div class="col-8 d-flex flex-row">
                                <img class="mr-3 rounded-circle" style="display:block; width:48px; height:48px" src="data:image/gif;base64,`+img+`" />
                                <div class="d-flex flex-column">
                                    <span class="name">`+value.userName+`</span>
                                    <span class="date"> — `+YYYY+`-`+MM+`-`+dd+` `+HH+`:`+mm+` `+weekDayPrint+`</span>
                                </div>
                            </div>
                        </div>                      
                        <div class="mt-2">`+text+`</div>
                        <div>                                
                            <div class="reply">
                                <div class="m-1">
                                    <a href="#" id="editSection`+id+`" onclick="editSection(event,`+id+`)" class="editFunction"><i class="fa fa-edit" aria-hidden="true"></i>Edit</a>
                                    <a href="#" onclick="deleteC(event,`+id+`)" class="editFunction"><i class="fa-solid fa-trash"></i>Delete</a>
                                    <a href="#" onclick="undoC(event,`+id+`)" class="editFunction"><i class="fa-solid fa-trash-can-arrow-up"></i>Undo</a>
                                </div>
                                <div id="editForm`+id+`" class="editForm">
                                </div>                                
                            </div>
                        </div>
                        <span onclick="loadReply(`+id+`)" id="showR`+id+`"><i class="fa fa-chevron-down"></i>See reply</span>
                        <span onclick="closeReply(`+id+`)" id="closeR`+id+`" style="display: none"><i class="fa fa-chevron-up"></i>Close reply</span>
                        <div class="ml-5">
                            <div id="reply-list`+id+`" class="reply-list">
                            </div>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination pagination-sm pageR" id="pageidR`+id+`" onclick="switchPageR(event,`+id+`)"></ul>
                            </nav>                       
                        </div>
                    </div>
                    `)
            })
        }

function pageBtn(page){
    let str = '';
    const total = page.pageTotal;
    if(page.hasPage) {
        str += `<li class="page-item"><a class="page-link" href="#" data-page="`+(Number(page.currentPage)-1)+`">«</a></li>`;
    } else {
        str += `<li class="page-item disabled"><a class="page-link">«</a></li>`;
    }
    
    for(let i = 1; i <= total; i++){
        if(Number(page.currentPage) === i) {
            str +=`<li class="page-item active"><a class="page-link" href="#" data-page="`+i+`">`+i+`</a></li>`;
        } else {
            str +=`<li class="page-item"><a class="page-link" href="#" data-page="`+i+`">`+i+`</a></li>`;
        }
    };

    if(page.hasNext) {
        str += `<li class="page-item"><a class="page-link" href="#" data-page="`+(Number(page.currentPage)+1)+`">»</a></li>`;
    } else {
        str += `<li class="page-item disabled"><a class="page-link">»</a></li>`;
    }
    pageidC.innerHTML = str;
}

function loadReply(id){
    $("#reply-list"+id).empty();
    $("#showR"+id).hide();
    $("#closeR"+id).show();
    $(function() {
        var aid = document.getElementById("articleId").value;
        console.log(aid);
        var cid = id;
        console.log(cid);
        fetch("http://localhost:8080/coinshell/viewReplyAdmin?articleId="+aid+"&commentId="+cid).then(function(response) {
            return response.json();
            console.log(response.json())
        }).then(function(data) {
            console.log(data);
            replyDataNow = data;
            replyPagination(data, 1, id)
        })
    })
}

async function replyPagination(array, nowPage, id){
    console.log("傳過來是第幾頁"+nowPage);
    console.log("傳過來是"+array.length);
    const dataTotal = array.length;
    const perpage = 5;
    const pageTotal = Math.ceil(dataTotal / perpage);
    console.log(`全部回覆:`+dataTotal+` 每一頁顯示:`+perpage+`筆`);
    let currentPage = nowPage;
    if (currentPage > pageTotal) {currentPage = pageTotal;}
    const minData = (currentPage * perpage) - perpage + 1 ;
    const maxData = (currentPage * perpage) ;
    const dataR = [];
    array.forEach((item, index) => {
        const num = index + 1;
        if ( num >= minData && num <= maxData) {
            dataR.push(item);
        }
    })
    console.log(dataR);
    await displayReply(dataR, id)
    const page = {
        pageTotal,
        currentPage,
        hasPage: currentPage > 1,
        hasNext: currentPage < pageTotal,
        id
    } 
    console.log(page);
    if(dataTotal!=0){
        pageBtnSm(page)
    }
}

function displayReply(data, id){
    $("#reply-list"+id).empty();
    $.each(data, function(index, value) {
                var added = new Date(Date.parse(value.added));
                var YYYY = added.getFullYear();
                var MM = added.getMonth()+1;
                var dd = added.getDate();
                var HH = added.getHours();
                var mm = added.getMinutes();
                var weekIndex = added.getDay();
                var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
                var weekDayPrint = weekDay[weekIndex];  
                var img = value.userAvatar;
                var thisId = value.id;             
                let deleted = value.deleted;
                let text = value.text;
                if (deleted=="y"){
                    text = `<del>`+text+`</del>`
                };
                console.log(text);
                $("#reply-list"+id).append(`
                        <div class="media mt-4">
                            <div class="media-body rounded">
                                <div class="row">
                                    <div class="col-8 d-flex flex-row">
                                        <img class="mr-3 rounded-circle" style="display:block; width:48px; height:48px" src="data:image/gif;base64,`+img+`" />
                                        <div class="d-flex flex-column">
                                            <span class="name">`+value.userName+`</span>
                                            <span class="date"> — `+YYYY+`-`+MM+`-`+dd+` `+HH+`:`+mm+` `+weekDayPrint+`</span>
                                        </div>
                                    </div>                                  
                                </div>
                                `+text+`
                            </div>
                        </div>
                        <div class="m-1">
                                <a href="#" id="editSection`+thisId+`" onclick="editSectionR(event,`+thisId+`)" class="editFunction"><i class="fa fa-edit" aria-hidden="true"></i>Edit</a>
                                <a href="#" onclick="deleteR(event,`+thisId+`)" class="editFunction"><i class="fa-solid fa-trash"></i>Delete</a>
                                <a href="#" onclick="undoR(event,`+thisId+`)" class="editFunction"><i class="fa-solid fa-trash-can-arrow-up"></i>Undo</a>
                        </div>
                        <div id="editFormR`+thisId+`" class="editForm">
                        </div>
                        `)              
            })
}

function pageBtnSm(page){
    // alert(123);
    console.log("page的ID是:"+page.id);
    let str = '';
    const total = page.pageTotal;
    console.log("第幾頁"+page.currentPage);
    if(page.hasPage) {
        str += `<li class="page-item"><a class="page-link" href="#" data-page="`+(Number(page.currentPage)-1)+`">«</a></li>`;
    } else {
        str += `<li class="page-item disabled"><a class="page-link">«</a></li>`;
    }
    
    for(let i = 1; i <= total; i++){
        if(Number(page.currentPage) === i) {
            str +=`<li class="page-item active"><a class="page-link" href="#" data-page="`+i+`">`+i+`</a></li>`;
        } else {
            str +=`<li class="page-item"><a class="page-link" href="#" data-page="`+i+`">`+i+`</a></li>`;
        }
    };

    if(page.hasNext) {
        str += `<li class="page-item"><a class="page-link" href="#" data-page="`+(Number(page.currentPage)+1)+`">»</a></li>`;
    } else {
        str += `<li class="page-item disabled"><a class="page-link">»</a></li>`;
    }
    
    console.log('pageidR'+page.id);
    $("#pageidR"+page.id).empty();
    $("#pageidR"+page.id).append(str);

    console.log("載入成功");
    console.log(str);
}

function editSection(e, id){
    e.preventDefault();
    $("#editForm"+id).empty();
    fetch("http://localhost:8080/coinshell/editSection?cid="+id).then(function(response) {
            return response.json();
            console.log(response.json())
        }).then(function(data) {
            $.each(data, function(index, value) {
                var added = new Date(Date.parse(value.added));
                var addedFF = Date.parse(value.added);
                var MM = added.getMonth()+1;
                var dd = added.getDate();
                var HH = added.getHours();
                var mm = added.getMinutes();
                var weekIndex = added.getDay();
                var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
                var weekDayPrint = weekDay[weekIndex];  
                var img = value.userAvatar;                
                // <a class="pr-3" href="#"><img class="rounded-circle" alt="Bootstrap Media Another Preview" src="https://i.imgur.com/xELPaag.jpg" /></a>
                $("#editForm"+id).append(`
                        <div class="reply-l bg-light p-2">
                            <div class="d-flex flex-row align-items-start">
                                <img class="rounded-circle" src="data:image/gif;base64,${memImg}" width="40">
                                <textarea class="form-control ml-1 shadow-none textarea" id="text-CR`+id+`" tabindex="1" placeholder="Reply here..." aria-required="true">`+value.text+`</textarea>
                            </div>
                            <div class="mt-2 text-right">
                                <button class="btn btn-primary btn-sm shadow-none submit-CR" type="button" onclick="postEdit(`+id+`)">Edit</button>
                                <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" type="button" onclick="closeEditForm()">Cancel</button>
                            </div>
                        </div>
                        <ul class="reply-r" style="display: none;">
                            <li>
                                <input type="text" id="userName-CR`+id+`" value="`+value.userName+`"/>
                            </li>
                            <li>
                                <input type="hidden" id="articleId" value="${Article.id}" />
                            </li>
                            <li>
                                <input type="hidden" id="commentId`+id+`" value="`+value.commentId+`" />
                                <input type="hidden" id="deleted`+id+`" value="`+value.deleted+`" />
                                <input type="hidden" id="type`+id+`" value="`+value.type+`" />
                                <input type="hidden" id="added`+id+`" value="`+addedFF+`" />
                                <input type="hidden" id="userId`+id+`" value="`+value.userId+`" />
                                <input type="hidden" id="userEmail-C`+id+`" value="`+value.userEmail+`"/>
                            </li>                            
                        </ul>
                        `)                    
            })
        })
}

function editSectionR(e, id){
    e.preventDefault();
    $("#editForm"+id).empty();
    $("#editFormR"+id).empty();
    fetch("http://localhost:8080/coinshell/editSection?cid="+id).then(function(response) {
            return response.json();
            console.log(response.json())
        }).then(function(data) {
            $.each(data, function(index, value) {
                var added = new Date(Date.parse(value.added));
                var addedFF = Date.parse(value.added);
                var YYYY = added.getFullYear();
                var MM = added.getMonth()+1;
                var dd = added.getDate();
                var HH = added.getHours();
                var mm = added.getMinutes();
                var weekIndex = added.getDay();
                var weekDay = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
                var weekDayPrint = weekDay[weekIndex];  
                var img = value.userAvatar;                
                // <a class="pr-3" href="#"><img class="rounded-circle" alt="Bootstrap Media Another Preview" src="https://i.imgur.com/xELPaag.jpg" /></a>
                $("#editFormR"+id).append(`
                        <div class="reply-l bg-light p-2">
                            <div class="d-flex flex-row align-items-start">
                                <img class="rounded-circle" src="data:image/gif;base64,${memImg}" width="40">
                                <textarea class="form-control ml-1 shadow-none textarea" id="text-CR`+id+`" tabindex="1" placeholder="Reply here..." aria-required="true">`+value.text+`</textarea>
                            </div>
                            <div class="mt-2 text-right">
                                <button class="btn btn-primary btn-sm shadow-none submit-CR" type="button" onclick="postEditR(`+id+`)">Edit</button>
                                <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" type="button" onclick="closeEditForm()">Cancel</button>
                            </div>
                        </div>
                        <ul class="reply-r" style="display: none;">
                            <li>
                                <input type="text" id="userName-CR`+id+`" value="${login.customizedUserName}"/>
                            </li>
                            <li>
                                <input type="hidden" id="articleId" value="${Article.id}" />
                            </li>
                            <li>
                                <input type="hidden" id="commentId`+id+`" value="`+value.commentId+`" />
                                <input type="hidden" id="deleted`+id+`" value="`+value.deleted+`" />
                                <input type="hidden" id="type`+id+`" value="`+value.type+`" />
                                <input type="hidden" id="added`+id+`" value="`+addedFF+`" />
                                <input type="hidden" id="userId`+id+`" value="`+value.userId+`" />
                                <input type="hidden" id="userEmail-R`+id+`" value="`+value.userEmail+`"/>
                            </li>
                        </ul>
                        `)                    
            })
        })
}

async function postEdit(id){
    var userNameCR = document.getElementById("userName-CR"+id).value;
    var userEmailC = document.getElementById("userEmail-C"+id).value;
    var textCR = document.getElementById("text-CR"+id).value;
    var articleIdCR = document.getElementById("articleId").value; 
    var commentIdCR = document.getElementById("commentId"+id).value;
    var userIdCR = document.getElementById("userId"+id).value;
    var deleted = document.getElementById("deleted"+id).value;
    var added = document.getElementById("added"+id).value;
    var type = document.getElementById("type"+id).value;
    var reply = {
        "id": id,
        "added": added,
        "userName":userNameCR,
        "userEmail":userEmailC,
        "text":textCR,
        "type":type,
        "deleted":deleted,
        "articleId":articleIdCR,
        "commentId":commentIdCR,
        "userId":userIdCR
    }
    var jsonReply = JSON.stringify(reply);
    console.log("回憶"+jsonReply);
    fetch('http://localhost:8080/coinshell/postEdit', {
        method:'POST',
        headers: {
            'Content-Type': 'application/json'    
        },
        body:jsonReply
    }).catch(error => console.log('Error:', error))
    .then(res => {
            return res.json();
        }).then(result =>{
            console.log(result);
        });
    await wait(100);
    $("#editForm"+id).empty();
    loadComment();
    loadReply(id)
}

async function postEditR(id){
    var userNameCR = document.getElementById("userName-CR"+id).value;
    var userEmailR = document.getElementById("userEmail-R"+id).value;
    var textCR = document.getElementById("text-CR"+id).value;
    var articleIdCR = document.getElementById("articleId").value; 
    var commentIdCR = document.getElementById("commentId"+id).value;
    var userIdCR = document.getElementById("userId"+id).value;
    var deleted = document.getElementById("deleted"+id).value;
    var added = document.getElementById("added"+id).value;
    var type = document.getElementById("type"+id).value;
    var reply = {
        "id": id,
        "added": added,
        "userName":userNameCR,
        "userEmail":userEmailR,
        "text":textCR,
        "type":type,
        "deleted":deleted,
        "articleId":articleIdCR,
        "commentId":commentIdCR,
        "userId":userIdCR
    }
    var jsonReply = JSON.stringify(reply);
    console.log("回憶"+reply.added);
    fetch('http://localhost:8080/coinshell/postEdit', {
        method:'POST',
        headers: {
            'Content-Type': 'application/json'    
        },
        body:jsonReply
    }).catch(error => console.log('Error:', error))
    .then(res => {
            return res.json();
        }).then(result =>{
            console.log(result);
        });
    await wait(100);
    $("#editForm"+id).empty();
    loadComment();
    loadReply(id)
}

function deleteC(e, id){
    e.preventDefault();
    var aid = document.getElementById("aid").value;
    if(confirm('Are you sure your want to delete this Comment?')){
    fetch('http://localhost:8080/coinshell/deleteCR?id='+id+"&articleId="+aid)
    .catch(error => console.log('Error:', error))
    .then(result =>{
            console.log(result);
        })
    .then(loadComment())
    }
}

function deleteR(e, id){
    e.preventDefault();
    var aid = document.getElementById("aid").value;
    if(confirm('Are you sure your want to delete this Reply?')){
    fetch('http://localhost:8080/coinshell/deleteCR?id='+id+"&articleId="+aid)
    .catch(error => console.log('Error:', error))
    .then(result =>{
            console.log(result);
        })
        .then(loadComment())
}
}

function undoC(e, id){
    e.preventDefault();
    var aid = document.getElementById("aid").value;
    if(confirm('Are you sure your want to Undo this Comment?')){
    fetch('http://localhost:8080/coinshell/undoCR?id='+id+"&articleId="+aid)
    .catch(error => console.log('Error:', error))
    .then(result =>{
            console.log(result);
        })
    .then(loadComment())
    }
}

function undoR(e, id){
    e.preventDefault();
    var aid = document.getElementById("aid").value;
    if(confirm('Are you sure your want to Undo this Reply?')){
    fetch('http://localhost:8080/coinshell/undoCR?id='+id+"&articleId="+aid)
    .catch(error => console.log('Error:', error))
    .then(result =>{
            console.log(result);
        })
        .then(loadComment())
}
}
</script>
</body>
</html>