<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<jsp:include page="../backendNavBar.jsp" />

<head>
	<meta charset="UTF-8">
	<title>會員 | CoinShell Backend</title>
	<link rel="stylesheet" href="${contextRoot}/css/backendNews.css">
</head>

<body>

	<div id="test-account">
		<table class="table table-hover" id="accountAddTable">
			<thead class="bg-success">
				<tr>
					<th scope="col" style="width:25%;">CustomizedUserName</th>
					<th scope="col" style="width:35%;">E-Mail</th>
					<th scope="col" style="width:35%;">Password</th>
					<th scope="col" style="width:5%;">Add</th>
				</tr>
			</thead>
			<tr>
				<td style="width:25%;"><input type="text" size="55%" id="accountAddName"></td>
				<td style="width:35%;"><input type="text" size="81%" id="accountAddEmail"></td>
				<td style="width:35%;"><input type="text" size="81%" id="accountAddPassword"></td>
				<td style="width:5%;"><input type="button" style="width:100%;" class="btn btn-success" value="Add" onClick="add()"></td>
			</tr>
		</table>

		<table class="table table-hover" id="accountUpdateTable">
			<thead class="bg-info">
			  <tr>
				<th scope="col" style="width:4%;">ID</th>
				<th scope="col" style="width:20%;">CustomizedUserName</th>
				<th scope="col" style="width:35%;">E-Mail</th>
				<th scope="col" style="width:35%;">Password</th>
				<th scope="col" style="width:6%;">Update</th>
			  </tr>
			</thead>
			<tr>
				<td>ID</td>
				<td><input type="text" size="42%"  id="accountUpdateName"></td>
				<td><input type="text" size="81%" id="accountUpdateEmail"></td>
				<td><input type="text" size="81%" id="accountUpdatePassword"></td>
				<td><button style="width:100%;" class="btn btn-info" onClick="">Update</button></td>
			</tr>
		</table>

		<form class="form-inline my-1 my-lg-0">
			<div class="input-group">
				<input id="accountName" class="form-control pl-2 p-0" type="text" aria-label="Search">
				<div class="input-group-append">
					<input type="button" name="submit" value="Search" id="searchAccount"
						class="btn btn-outline-dark my-2 my-sm-0" />
				</div>
			</div>
			<hr />
			<nav aria-label="Page navigation example">
				<ul class="pagination accountBtn" id="pageid">
				</ul>
			</nav>
		</form>

		<table class="table table-hover" id="accountTable">
			<thead class="bg-primary">
				<tr>
					<th scope="col" class="id"		>ID</th>
					<th scope="col" class="name"    >CustomizedUserName</th>
					<th scope="col" class="avatar"  >CustomizedUserAvatar</th>
					<th scope="col" class="email"   >E-Mail</th>
					<th scope="col" class="password">Password</th>
					<th scope="col" class="myShell" >MyShell</th>
					<th scope="col" class="coin"    >Coin</th>
					<th scope="col" class="date"    >JoinTime</th>
					<th scope="col" class="update">Update</th>
					<th scope="col" class="delete">Delete</th>
				</tr>
			</thead>
			<tbody id="accountTbody">
			</tbody>
		</table>
	</div>
						<div id="ttest"></div>
</body>

<script>
// 這裡要放 loadAccountByName() 但是function loadAccountByName 未完成
$("#searchAccount").click(function () {
    loadAccountByName();
});

// let dataNow = {};
// getAccount();
  allAccounts();

// pageid.addEventListener('click',switchPage);

// function switchPage(e) {
// 	e.preventDefault();
// 	if(e.target.nodeName !== 'A') return;
// 	const page = e.target.dataset.page;
// 	pagination(dataNow, page);
// }

// function getAccount(){
// 	$.ajax({
// 		url: "http://localhost:8080/coinshell/account/getAll",
// 		contentType: 'application/json; charset=UTF-8',
// 		dataType: 'json',
// 		method: 'get',
//         success: function(data) {
//             console.log(data);
//             dataNow = data;
//             pagination(data, 1)
//         },
//         error: function(err) {
//             console.log(err)
//         }
// })
// }

// // function pagination 分頁功能
// function pagination(array, nowPage){
//                 console.log(nowPage);
//                 const dataTotal = array.length;
//                 const perpage = 15;
//                 const pageTotal = Math.ceil(dataTotal / perpage);
//                 console.log(`全部資料:`+dataTotal+` 每一頁顯示:`+perpage+`筆`);
//                 let currentPage = nowPage;
//                 if (currentPage > pageTotal) {currentPage = pageTotal;}
//                 const minData = (currentPage * perpage) - perpage + 1 ;
//                 const maxData = (currentPage * perpage) ;
//                 const data = [];
//                 array.forEach((item, index) => {
//                     const num = index + 1;
//                     if ( num >= minData && num <= maxData) {
//                         data.push(item);
//                     }
//                 })
//                 console.log(data);
//                 displayData(data)
//                 const page = {
//                     pageTotal,
//                     currentPage,
//                     hasPage: currentPage > 1,
//                     hasNext: currentPage < pageTotal,
//                 } 
//                 console.log(page);
//                 pageBtn (page)
//             }

// // function displayData (value 在哪裡?)
// function displayData(data) {
// 	$('#accountTbody').empty();
// 	$.each(data, function(index, value) {
//         		accountList = '';
        		
//         		accountList += '<tr>'
//         		accountList += '<td>' + value.id + '</td>'
//         		accountList += '<td class="name">' + value.customizedUserName + '</td>'
// 				accountList += '<td><img src="data:image/gif;base64,' + value.userAvatar + '"alt=""></td>'
//         		accountList += '<td>' + value.eMail + '</td>'
//         		accountList += '<td>' + value.password + '</td>'
//         		accountList += '<td>' + value.myShell + '</td>'
//         		accountList += '<td>' + value.coin + '</td>'
//         		accountList += '<td>' + value.joinTime + '</td>'
//         		accountList += '<td><button id="up'  + value.id + '" class="btn btn-info" value="' + value.id + '" onClick="update(this)">Update</button></td>'
//         		accountList += '<td><button id="del' + value.id + '" class="btn btn-danger"  value="' + value.id + '" onClick="del(this)">Delete</button></td>'
//         		accountList += '</tr>';

//         		$('#accountTable').append(accountList);
// 	})
// }

// // function pagBtn
// function pageBtn (page){
// 	let str = '';
// 	const total = page.pageTotal;
// 	if(page.hasPage) {
// 		str += `<li class="page-item"><a class="page-link" href="#" data-page="`+(Number(page.currentPage)-1)+`">Previous</a></li>`;
// 	} else {
// 		str += `<li class="page-item disabled"><span class="page-link">Previous</span></li>`;
// 	}

// 	for(let i = 1; i <= total; i++) {
// 		if(Number(page.currentPage) === i) {
// 			str +=`<li class="page-item active"><a class="page-link" href="#" data-page="`+i+`">`+i+`</a></li>`;
// 		} else {
// 			str +=`<li class="page-item"><a class="page-link" href="#" data-page="`+i+`">`+i+`</a></li>`;
// 		}
// 	};

//     if(page.hasNext) {
//         str += `<li class="page-item"><a class="page-link" href="#" data-page="`+(Number(page.currentPage)+1)+`">Next</a></li>`;
//     } else {
//         str += `<li class="page-item disabled"><span class="page-link">Next</span></li>`;
//     }
//     pageid.innerHTML = str;    
//     console.log(str);
// }

// var img1 = 'data:image/gif;base64,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'
// var img2 = 'data:image/gif;base64,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'
// var img2 = 'data:image/gif;base64,iVBORw0KGgoAAAANSUhEUgAAAEEAAABBCAYAAACO98lFAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAB9dSURBVHhehVtbk1zXVf7Opa/T0zM9M7rMeCSNJF9kO04cJ3EcEgLkYlNQgSIPVEHxA0LCP6CoogqKlyRV8MwTL6GAB4qiKiRxQYidxElklx1hS7JlydJoNKOR5t7T93Ph+9Y+u6elJLBGu/c++7Lue+21T7eCV/96NQ+CCAhyIA8QBhW2gSiMwQ4WIMtyBOwLo5BDbPwKCDjJlzAMuS4rRtzY/wdiYRKynHSLtiDNiY8d4iHXH/mahJzzBWEYGM/+2bXFi63yYhmuLE0Q/OhvNvNSWHJ9Yj4qC5sjJoH0R6QeoZ4FehKxsXBawmdrsq2xMfBZ66XE/wseVoKnaWuDEElGhqlc3+dqCZKK2UL4zPHIf5Pr85xz1JbiOOYMFGA4GoAY+Y8EcpYgjITrQQSF2qIosiJBVSaFNGWpX3XBjCOcGzEJH8UR+0mjmPMLZWJ9IF6KttYYHloyKJTox1ybvBF3xDHveZPK1lrhkFBaI3n8vFReIBoByJxKEFstsQWeAU/MCyXwY5PjArV98ePOWxyzIm44ZHLbflw0WcYN57qGmfOlfHnCmCZxTra1jYnQGYmERMPz5WuB49/NMzaKsdD2ChXFfmNMg97qWuQRewFEWKC+SUJxHD/Qp3VhqPl6llAsGV2Shd1UN+fKuuy3ojanCr3V4iXSRAqkmovMXBxULaz2mXKcfAV0c/Hm+fa8H4GUpjgnz9K8khXrN61SyyTt7FAg8EUgwTwB3xZMzhFMPqtScUqRdUiO61S8oh7cAq7Pr2G0HuNQOYLC0lJAARawo6Kf6zyf/tnVxVyjKRqOjtZxvVQvQk5zsqhAbZWUQUdeMInYF/WVStIotW8EnJAqLho7vCrWr9iguZN9E0X4x1uGy2OjWYxrn5tCcuPJ5hA8X5xhtcbsmWs8+DmT/Z5+JPwemWDMQNH2ICT2rCGN858QGlPqtiUUTEeRcNhaal/Ms8jiHHG45fayhvrYnixCqQBn1qKFhMPw+jl8Et3xnEIw4dWfKYtF9LV6clyg2vepeAjlduqY1JBfODnZI2IPc4gQMU+SUOvYR03aPiX5cdFupP7ZdnvY7+NcAcHHCLUnCuP2Uc2iuMDAT3rCJQVJMPbzeZI/GUnF0yICM8hYKcVczVFbfa5NpIRQgUYTvJCToD5NFjiCXEAEantwNnCg0GLnuEqBc1yMKSplIspbe7L4vmJcLI0L8bukxz2LBY9bXjr2XPaLZz9uXXx4WEa1vRQ05pFAak9GeTHix01zbE72CdGDz66tpyOCTnlSjgVh1kdC67lQzAPFzYvobWMjUK9Eam1PU7Xwi5anZ/RFkP02bm3Xf8STe1acUY+wEPnkYgdGqCBgwFpHu3dl7VGBq8XEg/1jAVm0hyWL8CnpScMEGUtCrWYZS5hhEI6Q0NVTEsnIR0p6w6jH+SkYet2GKhIu4aBTGK2A89UnGgKvEBdzNEnxgW0T18EvKMMzJo0LmSaoHrc5X/vfrGJ0HBEJ5xiQoE5oWcuKzvaizWWS3pVin4slKTSJRsSfodYNUO/RhfsjRIMUcTdHtR+gNiihPpD2qJByn7hIj4eX0VPbaKuIJ5cWj3nX9iOlgIpWDPNZqMbMqwtF2NjrXz/Io+jBREcTHQiJiwtuTEeTGxkrqZhrbeGQ0Gz7HH8MXJeGQ0RZjDjhWkM3ogf0MJoaIZ6L0YsOjfFsyGNwlKF5uISQ7VLGXq4fUWA1FBuEz50BjrYTysUCQZK4lNgLqwNAi3zsUK1x3R2Ci1/fz0tx2SarUzGhWGZnqDR6pDmnfRstkEvDxiGlYpTluGYJXJ+Bo4+kNERtWEaW5Ngpb6PailBZjlF+IkBlNkeFjk8MVtbX17H97l0MdzIc757DbOcYKJY2HJHpM8CIpaBAfiSY+HECHvHnZjDbsdk+75HxFH/6wx6V8I2DvMT0UZOtkAGBXN0EJDKvBPU9DG5LOE/xLBqYbtxOFLGIez8lk524h/hUB63HK6gvDlCtTtN+ZYQjzhyS2UHCuVT+iPiGKW7urePKrfeQHIY4P3weU4OmbdE0SBlDSIRGMs8gaAN4YzmLSxZnXEYRGlR9bBfaUv9gyG3mI7GB2lSc9qz+eS0LNIfDBl7LlrSwzxdTSFGoFuYEKaqsa2mAfmUPeWsT5z5RwunHpnBivo5ydYEyVJDcS9B9p4fBWoKwTYXvZuhv5OjeKaE1XMEzSx/HTKuKq9lr2C/vWFDUXndcywiqXf7gagVjF5DFt1leCqLsZhB7f6K5LmAGb3yzTU8ojyXWJDWlJYGvBfIMOoUhlR5ESBcfaUfEFJzGCqJ3jOIRGnT/ME5wbel1dHci9F8HnllexpmPzuH+YBPpTAn7dNbzZ5YRb9JTtlN027QyvSGJ9Z6Alxxl8vUOVkdvYPP9Di7UX8DMcJ7bwcUCsSjjyuFlbe/u6hP/PpVWv8nDNeTUDD1Mh04J5VLFBnXkSGPSgoSQOPIUERKCmEeU4ZCUNkj+HE7rFzHFBbWlMMmQ1Ea4nV/HG+uv4Usf+zzatzK88+Yass40Vn6zioVnmnh08QT2f3of7WSKLh5hmA3Rz7fRKbW5TWq8SJbRqDCgzmRYy6/hzqVDvNB6EdVBjcermHE8SGgxJl7dFnG8ewV4r7DnYl6SMbK88Y1OXlFgJOPCJAfR5JDMyFV0FBlqTtARmSsusC0hiZKnwNFzwLM+UCRPqQB6wW41wXvRRZx7dBbd9wL86Ls/x/5SH82TMbLVEVrNJq7uvY7zn/oEfufTL+LdN9eZG9SRV26hMpyhQrhfeZrkOjpHCRZqpxlH6rhy81Uk2018svxFoE/yEYVhoiYZAgomjvVqTkoYx4tCGTKUgSzFvoHeLJnliUAqDZTxcQ1FsjlSiHTj+oSEStEz21KIkOoer9TbYgKDX5xyv5RzrLXu44cz76D/8Rncp4X6rRG+/NVP48zCCSRXYlTrLVzO7uK3v/xrCMpt/PCN7+GFLw1RXu6hXb6AvZkG40gd7SjFYSlFpzrAvd46aoctPH3+Cdwb3cButkcj0SEpjEQVbya6+LHt6WqVB0B8m8FNSERfefEv/lKub0JTEnfM+UUmvYFZWtooOmwOH7VdXZCipyiql0Z4r3IZ/7r7CpLhNq5++2dIr4V4/Jkl5McPMResYO1iH5cGO9iem8Lm9bexsXmIm2s8GnY6eOGTITr9GjZlYh1nAyZUJJXoFRqfY9I4OX+GXrKPjY0NnKifQ8hjR+aRJ5g3SxjXNLlc+6h/PIf/LAR44cfCUViBFlltupXQbtz3a/uRLPcrFSCk7K6mOQ7qB7jZ3MCf/dHv4Wu//wf46h//IT60dBy77RI2hzz+zgZYrd7AvVKGu2kfj184hUfmpjFKE/z48hAXf/ABHlveQHXIPIBElDnEPGuyOMSonOCwt4e0XcGppWPYi1bRTzsmqItgvwwe7PcGdkpxbfdJkIiFnMUEPdjGGGvQLkicpEzeAjfdXxDzzK4yATpEB/dba/jil74ADOpgTMPyR85j5vlzaH0kxHf+8Z/RZYY4PFNGn4ZOGAh7vQaytItPPHsSS0+l+LfX1tD/gGl0LXGWJW0puZSwTS8dMe4MB8wmo0WUj5Vwe3Sd43o/Kp6NnQnQ/pe5VLtBC95UhJPJKcjJbW0vuAO1zU2KtgP1yfGpCK4JmAcoPiAtmQKCJ3pY/tBx5Dd2ka73sPPWfexf6mKqFKG3w5jwlT9FsjCLQ+7v7pND7Cc9vHl9GyunlulF2zjROodo7jz+4Z9+gtaxFSqpT0/IUKHLVnj8Vng+64juJwxmWQMzswuMCzxmFZzFm2PyV4KM6z1hUlbr0bPc3UdSTdDxQbzW9lvAg56MLG99OmxGap/PcHCyg07vANN7IfbfvssY0cT1u7ewNtjGlYMS3t+MsHGljadnmQCtzGLh9CwuVcvYiJZwLW3i9bcu4VRtDnPHFxDcvY0S48BUHmGayVaV/sd0AzHdo083EnuztRbvGwcYMguV2zjHdLwf8eyElYxm2IntYEV9tL8pQLOKLVKA+lQ5JB7lWB3szhPuWJ4GabyO/vIh1tDDY489gVJeQnemjJ91/htTj/K+MJ3i+PQeZuMugnqAT3/mWZzeWsNXf6OK88838cq7q7iKGu4uLeOD7gijxTJq+QatXUM9bVAJU6hmzDBJNJJwFDJlml0rNZBXe+gmbcsXChsbk47rI5CMk14wVhJxMQ1gqspGwL1iqS77x4ISaGxpymp6osUCSx1IpUrVH+Z9TH+mjuHhJp4/zkj93gBT3TpmG8fwyU89ixPHc7T7bXx8ZRpL07s4e/IQS8sDPHnuHPY/WMUXp+pYPnUS87wjH3Qi/OftTXz/7T28V23i55feR6tCy4YLqPDmWWbSFEU1pOQ5Z8ypB1VQW9iPB4joJbpNyzvzUDcFxQKvCucdigdeeCnEJU7KidQhL6Do7nsAAufZVH7YdmNR9JcetaBQKC8xLPMH2OrsYmF4Fld/egs/3jjAxfgeLud30OkkGLV7aM7P4d3VbTTKU2gyTU262zi9soAffO8Aj3WqOIV7uHM1xXArQRLN49r9Br51cRdb1+6hETVJh9kqo0NJNxEGQb13zLkHJbTuBz0aYsjgrEsVRTWrO/FNCgPlDPIAD1KA8wyX+9hLFZug406IqUSeYGZxE5y1BcICp5QpZejiF/MKvHung60rJWytvY3yyjuY+9h9HDseYvfeiNdmWbCHWmMaiWVnCRkd4vT5ZczWZ7E8G+N3f+txtObm0TjOGMCtMz8zhbXLdzDfbiDdnWZGqD3PEyCr8ICgN2TKayiwAibvFqOgjXa8zcyCsUKewKNaGa+sfBQbHPhYIAXYGOU2QxtISeyQy6vIMzRIzyoUIE/RRAdqhhxMD2axvdFGsxny6FpGtr+Pqa1LWDm2j2G9ji7V2KgcYr7axfQMj75WHc1ji8wql/G5l87hYLaFv/v2+5g5S0LMF8rBkN4xxOf2K1jCSbTvMhUv6wJEBfDGGVMZJVmQQTyRe9NoQ1I5xC4GjElD3gWUAGWJ3hu4i5Pj1gnvwXuFPpUruv3OHMA0wl4lSJpkWiM9RVB9LW7ntqZoDtdQh6gPyri9fxuVR0d49pELuH2J0ZvH3PzJY3j85BQq0xR6YQYxI342e4bpwzlsl05jlWvThUfwrf/axN7OIq6vJrj+boq5nRTnugmOJ8wlqrxN7vIqHjbJEaVlwC0HdXt7NYoPmfdTaJ1OIRWeH3JL7POk6vDylbDNC1KszWHmome49FlyqdgdotCJxQQJ5YsHrynKakePFKM1OkVV1B5Ra/EgxJO1p/HyW9/FwkczPD77DC7+R4730hXsNhYRzF9AUj7Lk2QRB1mLpYZD7keyitbyCVzb28QB84iN9gDx/gFmByXM4zjmy2cQdIDdjQFPmzLoA8wTWMf6/jCj1Ts4CA+IF+gNeuSFMYGW0ctavcRNA247eYpJoBjxYEwwZZj08vbCRSwveAg0YsFPSmA0Impqmp/0DpVE2yHJsDB1DKs7t/GT69/Dc8+dxAqff/Lyj/DBwSGuMoK/lTdxJa7gTljGfZrxkFYaMshlUQOb/RwbO4eId3M8RkWc5vV4IeQNkil2g2u7PQZS7kddlDKmjYOwg16ljZ3gHtrDLoabzCb7VcYFeg1lkfB6lwluK4U8eWxKqzkpHXhZ/ZHpPEGFmpmcaFuBdUZr6/qcc6bOYuUV2hYqujZnuuG1tlGPa1iZu4C3b17Gh59ZxGeDU9j/ziV0r2/QQgG2gx5vkz3s8Xrco2vuH7DsVNAbVihEjtPMD57oxjjHfKFMRR8G91Etl7A93MfuaJfn8RB9JkbdygH2SvexRSXsbh5gcAfMI5hcKVjSUPqGK6GX0S/Gnq0YwY8HYoLaUoZ6wozCJZys9/ypogx75TqapGAY804QM9qWWPNWy2EuZr/7zpEzT3axHd/B51f+BIt3PoxjpRXcbV/DUx+ew+cWzqD66i3svfw/GN2muye8CjHpOdyPsXO3i3K3i7OHXZze7+O5bgsr+Qrmwlls0s030wOcSJr4/uKPsN7fwe72GmNBG72pbXSYHO1d20G0WsLx6ilUKUMlYU5J98wlDAOohXfJImOx1uHpjaf3APrBh04XeUD0tZf+3K7SepDwWmX6MjW69wYCCW+v37nOHZ0Bpkh8bXoVzVYD1fUGXll7E+tb29y9DZyYirHAq3Kjxjxvv43+6iY6BwPkvRLyAx4OPbo7r9rpa9dwNmUKzWSpyQD4enkbr4TbGPHIbDJReu4lZqWNKvZaS+iM2P/OfbSvcvtkCyj355h7LKBWo9BZGTFxlENFD65huh1KETSUffMu6eTJMm7hImZMamgcE6ybHwk7E7qUiwXKtJwbWSApFlstD+M9fr45y6vvk/hgcB2Vz2yi/MwGrnbu4l8u3sIPb95Cygh/4ZFjeG62ice3DnHs6k0cu3ELyxt3GAT30aRHVSsVbCb7uBndwzv1TawuhVgj/3uzV/DSr59mwtRGdYUnzIlT2Fin8kvnKOxJTI+YSZaneapxS+UNiswTgNtC+5YuTgZlafFvbJssHiST5Qoy6tdepCcUX75oioKLVjmBFVqcgpR42HWJwVlzREvvA0t7fazub2LwQoqnzg0Z2TtYWImxXxnhZnuIW+ubGKXMGudKTI5CVBncyqU+6wP0+h28/Nr7eL/SwL2oj40ZKulTp5iEJdi4cZ8xYg9nz17AweUerl66gum1EPP5I5jKplHhdZrJOaIGYwEDYcxESt98xUymYuYUliwpAaD/63iUJ+vPG1Kgtr1ofeubffveQaLaOIuUwau7C34U2OkvoLvxk5obxowRnFwZ5rwiJ9gub+HEF1L0qncxyu5i7lQJU3PP4UaygHfuMLBdX8PMvXUsMhucniHuik6ZGG/9+Dr+9m0etcdOIOjew1fOMB4s1vH2m9fxWTyKpRsz6N3mVrlQReOp+0y5F8kXXT9l9qj9Tx6qVf1IhLySt4zClhhMFa/KPIkw4oA4V1CXcSVPoQR3bwjsHWPwcykh9j/bKyYT3FsX5uyGR4FSRwk1yaeEGtJrtWqnh4hHW44pjGj5IS9HPWqp286x3dvGVvkm2vMDlB+fxuLTczhNHMPuFnYYDDc3Etz8+2t4rVrHEx99FPO3YzxyJ8Ncaw7N4BgON5QRllFq8Wp+voThNFBnPImYJucjUqcSShXeJ5hj5LxIKNDpqz+dBJG+WdeWYHZpbi+5CgXoWeC3uH0NN6kEDbspbpK9PhdSqZqgb4jtuCTBCvODsEsk27pZigjP7PIIg16diytIalton6ELn+9gZoHJES09yg6RzxJHaR53r03h8N+fxMrwDNI7q7gzPYtqPIXSqI+QQsa1lrWrT+0iWOCxlHCM7h4w+qdDfYFChVQpqFxW30CQX/0AVV5gv2GyX+OZ5GZ1HYaSw+cI3iNMCbYdqAQ/KNCElEHPvsWh0HZEcG+w14JmSGSlIcf3iPoex5MSEgadIdPUuB4jrTOJmuGtcJ5X3lqb67fAlA9TJ26hfjbG9m4Vm2/NYeG7y9hdncYcI7liVsDt1eVaMJjGNF3eGqD+RAV5mcpIIuInPsvU9Fsp9uteL8MoSvMzpuC27+n+egOuDMuuz3J959Jj4b0n9PU1nCUMMr8GJybYdZRFvxcQIjteOCa68q2MgWdED9BbiBH7dJLEVFrOfCInkwH3Y+WQ7nrQQJhMoz5NQRa5bXhx7q9P4/j6I8iHDdTDERmmnmjltJagQpcucc+XayGmjpdRpgFiBm528Wiu0TOZaygpIiZmONqoOhPIVMhALUTyWN4omEbrNJCgMpqXzYNktLjANo9IuopuW3yYnGYak3WKZ4HNsQ4i56d+XKErij7VTlmU4qbMqvKYLsr0Nm/sIp/hSdDo4WA7xt03qbEPWqhuNRncAlo05kWHa3h316+L9Z4kq5OfJr2hwTEmJs4geglSCMX2+Kt/MeSZJL8STs86+ixTVLf69BvKh8D6Cdw+tJoFQc4zr3Aa8h7iCad6Zlu1qKT6ESWJpWSSXmiFVzwEtCAvesjrvNlEQ9tOQSfCYH0W/cuzKN1YxNR9ngaHtM6ILqwjjOR1XY5KVEo1QHma1m3Ro2qkzy2mP51K4s1+K0FSXoAxuE7yK6MINF4EQsmhamKNZHJypeZHJoyr5VxkgM8Kgip+zBQgJORYbSUhAc/MuMJIrO9zZUW6aUCr6muxUT5AQiHzNlOYnSbqa2dQ31lCo9Pi0VrlnWFgUTum4Lm8gDHDAh09IZpi4Jsig9x7xocUoMxPAY+8ODN4oWQs9vCfvfOwgSIvYL/NYZ8SO7tVmnGLPtZyAssYZXXte2kx1/s7qt0dCI5ckrBPhChkpsTKvINEKiHSaVqZET9t0lpkPCiLsQQRc/lgwHNt0EQ0atHi+paZATgaMboTMxWk3yoqiGYNXnt1/NfJFPOIsEEUVHBOujGPyYgF+vGIBKQiFBMC8kE3YUfxrlAXG+OZ/LHk9vaJ/SyZfh0vo9keoRJSvZCUDM7DLTA615fmJICUoloUnba0B2U106YUZf3ap0yaakxYGszSaiQqBdCymqv9rhc1ut2FjP5KMSvM78O0hEzHK90t5FpZXyXmNgqn2M8tEKtPJhVN/2e8EU3Br+NRIwWwUUxhzXF70HbQc7HFWT8soxQhz7eGFQ6qNoxFvxZZn41brx+2LC3hntUXsKgQcZmEaBHhj2mlkELra/VQoV2/U+qpkBGeIKHST26djNkjtAWokHyaHskTwoIsiehCJNoWCI1h7V4nmJiw9wGFUCIqXr2yxK9AwgtMPhb3TBw2X55BPNrbchGdtw6OFnsEnK6dxxbH2KftItdMpHGdELpW0gPsa3ris98xKDGhxZMBc4sRl1EJ0E9wSEbJTFylhzRoed4nInkBA2LAInw8BU1B+tGHXNm2qI5DLlbJA9eXpKOxxen4hdyFIsSneGafnm3bq7DfgjzbmiYgZxSUhN1bVdfrPUCL9Lpb6LTYrp3SJvv1ztipSJTJgFDRUsotNC/Tmx4M7X+r2F7Wi0HNlfF4EoD7n9k2lUBPoxeEjC8WpLT1NCei0OJLAosahR4lAyvcyeynMsive+GjQCieOY/b1b57EH8SlFT12k182R2CPVpjLHGcTYrNhjE3Lg5sC+hZwyxjr7D5rItngfcarfG/E1K7XCrR7UmUirCApDatHDLf15GqOiqzYces3JsUTYlEyg85qKKdTgbxIpzOQMaSmFSvcc2m9ftx1WY4zy9r39ZiqcdetnI1DatFRxPdKXEkoFeA5mnMske2dV5LWFtbEHDrij0svNQ7dWIWlQunvOgok9MR6mIC+xlDgphzpZTCE2hCkSVedrIwe6DFNOZwO5pO+EnwsohH1Xr2vHqwPMMU5o5HJYsK++xwLjOJVa4k8IiMcAES1rRsf3xmMbfkn5IPFfbYOv/zPilEMSMz/9PeL5hm0bPii73IEUJtKwrtsStXEIiiNqFtN/0VxnL8cPZDPHqjGa8cU3FtTvA4iDu0ICHGCGrrSqqon8qFubcmQUjMUgUYUSlOmuWHFCmkQm8vOhV39XKDgsojbKLmcpm9AeaRS66447XrWeQt1nJzdT+gWkmTnxYcRccV4XkQnIAqkzwKvALEh5+jIpyC0DIoMuTd3IBUZEExO4lgPE5Q+4F+tW3EzffFcVzMNw24ZzXMg4whKo61TiidCLoYSXjZXkUGcT8V0nxhcX8ePC8SzGgWfQ8Xjasez+GfbQd1csT2ih/04PtUpN2HNfygVzim/L4WKrmotobWm5Ipmu26Ym9rhTzFXoVZQNWghNdcpwAVeYK1FQfEL8Hz5Nvq93FqEjTmLC8cXiEuZrkJ5NmOEXKmyYKEqaoYFvi+SfB9qi3hKHgV08KrZ1lVGR+xFgw4CwhUuxyeitG+1KnAPMPm8xTQFlKMUPywr87Yrz8ngFP8w3w5wZyFJ8d8WwpwKXShYKvFuJmFOLnYrCIKBP3HLv3I+5cR07P6x8WYFBPim23O0bNpl8/2XwQKb5Ii9AWq7guyhIQOSrx7SFGcb+5uPOjtT3FC0UOoHqvdqzOHx9P34Pmc9IQHeZWC1Cv8R0WfAhcYCyQC7wUCr2GvIF9rvhU9Hi3l2okxw+kY8f/Dzhhk93gOpXdGKNgxdxcdR8vjkOCaqwHPg/hU8V6muXp2a9x6jfnxYpk9y9uThCGYFynNp3o1VMwoak/IDbHNfx6h9RcEbYZfauAY8Ixovm/rtb7A4pvhpEKMTmElKUB/7NKz1vmiWepztVOKiubat0gF+DEPTnhXPGgOP4taOGmEXNqTRvT/hrWvOaacn9gsi/appVlCROwayjGhYtR2risLOA9yzDkr+Jc1Akt0+KwfUegrrFzvC7k3dZi6A5V1MOSxNSoYJ/6JYgTHoD3ObcLLGRfxWUfdL26TSZBuZDfJbrHHrCEj2UsVskD3MA1KYNOaLO00mtnLCBKQQBy3o4wKsWDK2h9vZjEu9ZpXkeC+LZ27n9/T8roPxO5nNdG4UABOU3H2sYa1icBwOOupX/cMCatn1+dme1oFaKgAx4dqri2+bPIQvPpXG/atnbCIRsgJImD0CCIs7epOYMlUgVk4HHkHk0ipIhvUcelnOK8ojkqjxQm2ZmKdFEwQLjMKNaJ5TsGTihAmGUEvWxU83RrR8OMC4RDfdjzS8pmlox5kPCZoeYL/BVHjAxzWa0+DAAAAAElFTkSuQmCC'
// var img2 = 'data:image/gif;base64,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'
// var img2 = 'data:image/gif;base64,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'

function allAccounts() {
    $.ajax({
        url: "http://localhost:8080/coinshell/account/getAll",
        contentType: 'application/json; charset=UTF-8', 
        dataType: 'json', 
        method: 'get',
        success: function(result) {
            console.log(result)
            $.each(result, function(index, value) {
        		accountList = '';
        		
        		accountList += '<tr>'
        		accountList += '<td>' + value.id + '</td>'
        		accountList += '<td class="name">' + value.customizedUserName + '</td>'
				accountList += '<td><img src="data:image/gif;base64,' + value.userAvatar + '"alt=""></td>'
        		accountList += '<td>' + value.eMail + '</td>'
        		accountList += '<td>' + value.password + '</td>'
        		accountList += '<td>' + value.myShell + '</td>'
        		accountList += '<td>' + value.coin + '</td>'
        		accountList += '<td>' + value.joinTime + '</td>'
        		accountList += '<td><button id="up'  + value.id + '" class="btn btn-info" value="' + value.id + '" onClick="update(this)">Update</button></td>'
        		accountList += '<td><button id="del' + value.id + '" class="btn btn-danger"  value="' + value.id + '" onClick="del(this)">Delete</button></td>'
        		accountList += '</tr>';

        		$('#accountTable').append(accountList);
            })
        },
        error: function(err) {
            console.log(err)
        }
    })
}

function add() {
	var name = document.getElementById("accountAddName").value;
	var email = document.getElementById("accountAddEmail").value;
	var password = document.getElementById("accountAddPassword").value;

	var param = {
			"name" : name,
			"email" : email,
			"password" : password,
		}
	$.ajax({
		url: 'http://localhost:8080/coinshell/account/add',
		contentType: 'application/json; charset=UTF-8',
		dataType: 'json',
		method: 'post',
		data: JSON.stringify(param),
		success: function(result) {
			console.log(result)
			console.log("成功");
			parent.location.reload();
		//  document.querySelector('#ttest').scrollIntoView()
		},
		error: function(err) {
			console.log(err)
			console.log("失敗");
		}
	})
}
 
// function del    // obj 是對應到 上面 function 的 this
function del(obj) {
	var r = confirm("確定刪除嗎?");
	if (r == true) {
		var id = $(obj).val();
		var param = {
				"id" : id,
			}
		console.log("delId==" + id);
		$.ajax({
			url : 'http://localhost:8080/coinshell/deleteAccount'+ id,
			contentType : 'application/json; charset=UTF-8',
			dataType : 'json',
			method : 'delete',
			data: JSON.stringify(param),
			success: function(result){
				console.log("result====" + result.status)
				console.log("成功");
				if (result.status == '200') {
					$('#accountTbody').find('[id="del' + id + '"]').closest('tr').remove();
				}
			},
			error : function(err) {
				console.log("result====" + err)
				console.log("失敗");
			}
		})
	}
}

// function loadAccountByName
function loadAccountByName(){
	var name = document.getAnimations("accountName").value;
	$.ajax({
		url: 'http://localhost:8080/coinshell/account/select?name=' + name,
		contentType: 'application/json; charset=UTF-8',
		dataType: 'json',
		method: 'get',
		success: function (data) {
			console.log(data);
			dataNow = data;      // dataNow 是對應到一開始的pagination
			pagination(data, 1)
		},
		error: function(err) {
			console.log(err)
		}
	})
}

// function update
function update(obj) {
	var id = $(obj).val();
	$.ajax({
		url: "http://localhost:8080/coinshell/memId?id=" + id,
		contentType: 'application/json; charset=UTF-8',
		dataType: 'json',
		method: 'get',
		success: function (result) {
			$('#accountUpdateTable tr td').remove();
			console.log(result)
			$.each(result, function(index, value) {
				List = '';

				accountList += '<tr>'
				accountList += '<td>' + value.id + '</td>'
				accountList += '<td><input type="text" size="42%" id="accountUpdateTitle" value="' + value.name + '"></td>'
				accountList += '<td><input type="text" size="81%" id="accountUpdateUrl" value="' + value.email + '"></td>'
				accountList += '<td><input type="text" size="81%" id="accountUpdateImgUrl" value="' + value.password + '"></td>'

				accountList += '<td>' + value.id + '"onClick="upSave(this)">Update</button></td>'
				accountList += '</tr>';

				$('#accountUpdateTable tr').append(accountList);
				document.querySelector('#test').scrollIntoView();
			})
		},
		error: function (err) {
			console.log(err)
		}
	})
}

// function upSave
function upSave(obj) {
	var id = $(obj).val();
	console.log("id====" + id)
	var name = document.getElementById("accountUpdateName").value;
	var email = document.getElementById("accountUpdateEmail").value;
	var password = document.getElementById("accountUpdateImgUrl").value;

	var param = {
		"id" :  id,
		"name" : name,
		"email" : email,
		"password" : password,
		}
	$.ajax({
		url: 'http://localhost:8080/coinshell/account/upSave',
		contentType: 'application/json; charset=UTF-8',
		dataType: 'json',
		method: 'post',
		data: JSON.stringify(param),
		success: function(result) {
			console.log(result)
			console.log("成功");
			parent.location.reload();
		},
		error: function(err) {
			console.log(err)
			console.log("失敗");
		}
	})
}


</script>