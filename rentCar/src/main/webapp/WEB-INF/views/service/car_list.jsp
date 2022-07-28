<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 목록</title>
    <script src="https://kit.fontawesome.com/166dc8a7b4.js" crossorigin="anonymous"></script>
    <style>

        ul {
            list-style: none;
        }

        a {
        	color: black;
            display: block;
            text-decoration: none;
        }

        a:hover {
            background-color: rgba(253, 158, 80, 0.3);
        }

        a:visited {
            color: black;
        }

        .items_container {
            width: 100%;
            min-width: 500px;
        }

        .items_container .menu_wrapper {
            display: flex;
            justify-content: space-between;
            height: 100px;
            margin-left: 150px;
        }
        
        .items_container .menu_wrapper div {
        	margin-right: 50px;
        	width: 200px;
        	position: relative;
        }

		.items_container .menu_wrapper .searchText {
			transition: all 0.35s ease-in;
			position: absolute;
			top: 0;
			left: -100%;
		}
		
        .menu_wrapper .car_category {
        	display: flex;
        }
        
        .items_container .menu_wrapper .fa-magnifying-glass {
        	font-size: 25px;
        }

        .menu_wrapper .car_category li {
            width: 100px;
            font-size: 20px;
            margin-bottom: 10px;
            text-align: center;
            line-height: 68px;
        }

        .item_wrapper {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
        }
        .item_wrapper .item_list:not(:nth-child(4n)) {
        	margin-right: 35px;
        }

		.item_list figure img {
			width: 200px;
			height: 200px;
		}
        .hidden {
			display: none;
        }
        
        .d-none{
        	display: none;
        }
        
        @media(max-width: 1200px) {
        	.items_container .menu_wrapper .searchText {
        		top: 50%;
        		left: 0;
        	}
        }
        
        @media(max-width: 960px) {
        	.item_wrapper {
        		grid-template-columns: repeat(2, 1fr);
        	}
        	
        }
        
        @media(max-width: 768px) {
        	 .items_container .menu_wrapper {
        	 	margin-left: auto;
        	 	flex-direction: column;
        	 }
        	 
        	 .items_container .menu_wrapper div {
        	 	order: 1;
        	 }
        	 
        	 .menu_wrapper .car_category {
        	 	order: 2;
        	 }
        	 
        	 .items_container .menu_wrapper .searchText {
        	 	left: 30%;
        	 	top: 0;
        	 }
        	 
        }
        
        @media(max-width: 480px) {
           	.item_wrapper {
        		grid-template-columns: 1fr;
        		margin: 0 auto;
        	}
        	
        	.items_container .item_wrapper {
        		width: 200px;
        	}
        }
    </style>
    <script>
    
    window.onload = function() {

    	var countPrint = 4;
    	var startIndex = 1;
    	var endIndex = startIndex + countPrint;
    	var docElement = document.documentElement;
    	var initialHeight = docElement.scrollHeight;
    	
    	let setInt = setInterval(function() { //스크롤 생길때까지 로드
    	    
    		listCars();

            let currentHeight = docElement.scrollHeight;

            if(initialHeight != currentHeight) clearInterval(setInt);
    	}, 500);

  let timer;

  window.addEventListener('scroll', function() { // 무한스크롤 이벤트 메서드
	    if(!timer) { //쓰로틀링
	        timer = setTimeout(function() {
	            timer = null;
	            if (docElement.scrollTop < docElement.scrollHeight - window.innerHeight) {
	            	return null; // 스크롤 끝 판별
	            }else {
	            	listCars();
	            }
	            
	        }, 500);
    	}
  });
    
    function listCars() { // 상품 조회 메서드
    		
	    	let xhttp = new XMLHttpRequest();
	    	let jsonData = new Object();
	    	jsonData.startIndex = startIndex; // 추가로 조회 할 상품의 시작 인덱스
	    	jsonData.endIndex = endIndex; // 추가로 조회 할 상품의 끝 인덱스
	    	
	    	xhttp.open('post', "${contextPath}/car/ajaxCars.do", true);
	    	xhttp.setRequestHeader('Content-type', 'application/json; charset=UTF-8;');
	    	xhttp.responseType = "json";
	    	console.log(jsonData);
	    	xhttp.send(JSON.stringify(jsonData));
	    	
	    	xhttp.onreadystatechange = function() {
				if(this.readyState == 4 && this.status == 200) {
					
					let jsonCars = this.response;
					let arrayCars = jsonCars.cars;
					let string = '';
					console.log(arrayCars);
					
					for(var i = 0; i < countPrint; i++) {
						
						if(i < arrayCars.length) {
					       string = '<li class="item_list">' +
				                '<figure>' +
				                    '<a href="${contextPath }/car/carDetail.do"><img src="/rentCar/resources/images/rentCar/'+ arrayCars[i].rentCarDTO.carNumber +'.png" alt=""></a>' +
				                    '<figcaption>' +
				                        '<p>'+ arrayCars[i].rentCarDTO.carNumber +'</p>' +
				                        '<p class="keyword">'+ arrayCars[i].carDTO.carModel +'</p>' +
				                        '<p>'+ arrayCars[i].carDTO.carPrice +'</p>' +
				                        '<p class="hidden">'+ arrayCars[i].carDTO.carSize +'</p>' +
				                    '</figcaption>' +
				                '</figure>' +
				            '</li>';
					       document.querySelector('.item_wrapper').innerHTML += string;
						} //if 끝
						
	                startIndex++;
	                endIndex++;
					}//for 끝
				}
				
		    	//검색
		    	let keywords = document.querySelectorAll('.item_list .keyword'); // 검색 대상 p태그
		    	let arrayWords = [];
		    	let counter = 1;
		    	
		    	for(let keyword of keywords) { // p태그들을 가져와서 id로 인덱스를 주고 text 저장
		    		arrayWords.push({
		    			id:counter++,
		    			text:keyword.textContent
		    		});
		    	}
		    	
		    	let searchInput = document.querySelector('.items_container .menu_wrapper input[type="search"]'); // 검색어 입력 바
		    	let itemList = document.querySelectorAll('.item_wrapper .item_list'); // 상품 목록들
		    	
		    	searchInput.addEventListener('keyup', keyupHandler); // 키보드 이벤트
		    	
    		    let timer02;
		    	function keyupHandler() {
		    		
		    		clearTimeout(timer02);
		    		timer02 = setTimeout(function(){ // 디바운싱
		    			
				    		for(let item of itemList) { // 검색어를 입력 시 모든 리스트를 지움
				    			item.classList.add('d-none');
				    		}
				    		
				    		let inputWords = searchInput.value; // 검색 값
				    		let filteredArray = arrayWords.filter(element => element.text.toLowerCase().includes(inputWords.toLowerCase())); // filter로 입력한 값과 비교해서 일치하는 값 반환
				    		
				    		if(filteredArray.length > 0) {
				    			for(let el of filteredArray) { // id 인덱스에 해당하는 p태그의 display none을 제거
				    				document.querySelector('.item_wrapper li:nth-child('+el.id+')').classList.remove('d-none');
				    			}
				    		}
		    		
		    		}, 200);
		    		
		    	}
		    	
		    	let words = document.querySelectorAll('.item_list figcaption p:last-child');
		    	let keyArray = [];
		    	let count = 1;
		    	
		    	for(let word of words) {
		    		keyArray.push({
		    			id:count++,
		    			text:word.textContent
		    		});
		    	}
		    	
		    	let allSel = document.querySelector('.menu_wrapper ul li:first-child a');
		    	let small = document.querySelector('.menu_wrapper ul li:nth-child(2) a');
		    	let middle = document.querySelector('.menu_wrapper ul li:nth-child(3) a');
		    	let large = document.querySelector('.menu_wrapper ul li:nth-child(4) a');
		    	let suv = document.querySelector('.menu_wrapper ul li:last-child a');
		    	
		    	allSel.addEventListener('click', function(e) {
		    		
				let alink = document.querySelectorAll('.menu_wrapper ul li a');
				
					for(let i = 0; i < alink.length; i++) {
						alink[i].style.color = 'black';
					}
					
					e.preventDefault();
					this.style.color = 'blue';
					for(let item of itemList) {
		    			item.classList.remove('d-none');
		    		}
		    	});
		    	small.addEventListener('click', clickHandler);
		    	middle.addEventListener('click', clickHandler);
		    	large.addEventListener('click', clickHandler);
		    	suv.addEventListener('click', clickHandler);
		    	
				function clickHandler(e) {
					
					let alink = document.querySelectorAll('.menu_wrapper ul li a');
					
					for(let i = 0; i < alink.length; i++) {
						alink[i].style.color = 'black';
					}
					
					e.preventDefault();
					this.style.color = 'blue';
					
					for(let item of itemList) {
		    			item.classList.add('d-none');
		    		}
					
					let inputText = this.innerText;
					let filteredArray = keyArray.filter(element => element.text.toLowerCase().includes(inputText.toLowerCase()));
					
					if(filteredArray.length > 0) {
		    			for(let el of filteredArray) {
		    				document.querySelector('.item_wrapper li:nth-child('+el.id+')').classList.remove('d-none');
		    			}
		    		}
				}    
	
			}//ajax state 끝
	    	
    	} //listCars 끝
    	
    	//아이콘 클릭 시 검색창이 나오게 함
    	let searchIcon = document.querySelector('.items_container .menu_wrapper .fa-magnifying-glass');
    	let searchInput = document.querySelector('.items_container .menu_wrapper input[type="search"]');
    	
    	searchIcon.addEventListener('click', function() {
    		
    		searchInput.classList.toggle('hidden');
    		
    	});
    	
    }
    </script>
</head>
<body>
    <section class="items_container">
        <div class="menu_wrapper">
            <ul class="car_category">
                <li><a href="#">전체</a></li>
                <li><a href="#">소형</a></li>
                <li><a href="#">중형</a></li>
                <li><a href="#">대형</a></li>
                <li><a href="#">SUV</a></li>
            </ul>
            <div><input type="search" class="searchText hidden"/><i class="fa-solid fa-magnifying-glass"></i></div>
        </div>
        <ul class="item_wrapper">
        
        </ul>
    </section>
    
</body>
</html>