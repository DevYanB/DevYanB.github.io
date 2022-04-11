let URL = './hw1_data/data.json'; 
  
async function fetchData() {
   const response = await fetch(URL); 
     
   let gd = await response.json(); 
   return gd;
}

fetchData().then(
    function(d){
        for(elem in d){
            if(elem == 'section2'){
                var obj = d.section2
                var img1 = `<img src = "./${obj[0].image}" style= "height:200px; width: 270px;">`;
                var text1 = `<em>${obj[0].heading}</em> <br><br> ${obj[0].text}`;
                document.getElementById("sec2_1_img").innerHTML = img1;
                document.getElementById("sec2_1_txt").innerHTML = text1;

                var img2 = `<img src = "./${obj[1].image}" style= "height:200px; width: 270px;">`;
                var text2 = `<em>${obj[1].heading}</em> <br><br> ${obj[1].text}`;
                document.getElementById("sec2_2_img").innerHTML = img2;
                document.getElementById("sec2_2_txt").innerHTML = text2;

                var img3 = `<img src = "./${obj[2].image}" style= "height:200px; width: 270px;">`;
                var text3 = `<em>${obj[2].heading}</em> <br><br> ${obj[2].text}`;
                document.getElementById("sec2_3_img").innerHTML = img3;
                document.getElementById("sec2_3_txt").innerHTML = text3;
            }
            if(elem == 'section3'){
                var obj = d.section3.text;
                var txt3 = `${obj[0]} <br><br> ${obj[1]}`;
                // console.log(text1);
                document.getElementById("sec3_txt").innerHTML = txt3;
            }
            if(elem == 'section4'){
                var obj = d.section4;
                var txt41 = `<em>${obj[0].heading}</em> <br><br> ${obj[0].text}`;
                var txt42 = `<em class="sep_head">${obj[1].heading}</em> <br><br> ${obj[1].text}`;
                var img41 = `url('${obj[0].image}')`;
                var img42 = `url('${obj[1].image}')`;
                document.getElementById("sec4_1_txt").innerHTML = txt41;
                document.getElementById("sec4_2_txt").innerHTML = txt42;
                document.getElementById("sec4_1_img").style.backgroundImage = img41;
                document.getElementById("sec4_2_img").style.backgroundImage = img42;
            }
        }
    }
);
  