$(load);function noporint(){$.texi({title:"Viki提醒您",body:"目前仅支持翻译功能，请见谅!",time:3000})}function load(){$(".textA").val("");$("#sound").on("mouseover",function(){var g=$("#searchResult").text().isEmpty();if(g==""){return}var d=$("#cut").attr("name");if(d==""){return}var f=d=="sp"?"http://tts.youdao.com/fanyivoice?keyfrom=fanyi%2Eweb%2Eindex&le=SP&word="+g:"http://tts.baidu.com/text2audio?lan="+d+"&pid=101&ie=UTF-8&text="+g;var e=document.getElementById("myPlayer");e.src=f;if(e.play){e.play()}});$("#cut").on("click",a);function a(){var d=this;var e=$(this);$(".language").show(300,function(){e.off("click",a);e.on("click",b)})}function b(){var d=this;var e=$(this);$(".language").hide(300,function(){e.off("click",b);e.on("click",a)})}$(".language li").on("click",function(d){var e=document.getElementById("cut");e.value=$(this).text().isEmpty();e.name=this.id;b.call(e)});$(".trans_nav .blank").on("mouseout",function(){c($(this).attr("value"))}).find("li").on("mouseover",function(){c(this.offsetLeft+64)}).on("click",function(){$(".trans_nav .blank").attr("value",this.offsetLeft+64)});function c(d){$(".trans_nav .nav_button").stop(true).animate({left:(d?d:84)},function(){$(".block",this).stop(true).animate({left:-(d-84)})})}$("#empty").on("click",function(){$(".textA").val("").css({height:"190px"}).parent().css({height:"222px"})});$("#tranlster").on("click",function(){$(".trans_nav").css("display","none");$("#search").css("display","block").animate({width:document.documentElement.clientWidth,opacity:1},550,function(){$(this).css({width:"100%"})})});$("#transRetuen").on("click",function(){$("#search").animate({opacity:0,height:0},550,function(){$(this).css({height:"600px",width:"0",display:"none"});$(".trans_nav").css("display","block")})});$("#query").on("click",trans)}function trans(){var c=dol(document.getElementById("cut").value);var b=$("#searchText").text().isEmpty();if(b==""){return}var a=$("#sreachState").show(300);$.ajax({method:"post",url:BASE_PATH+"/select_word.service",accept:{"Accept-Charset":"UTF-8"},data:{word:b,src:c.src,res:c.res},success:function(d){var g=$("#searchResult");if(d.isEmpty()=="no"){g.text("数据查询失败请稍后再试！")}try{var f=JSON.parse(d);g.text(f.res?f.res:f.trans_result.data[0].dst)}catch(h){g.text("数据查询失败请稍后再试！")}a.hide(300)}})}function dol(a){return a=="自动检测"?{src:"AUTO",res:"AUTO"}:a=="多→英"?{src:"AUTO",res:"en"}:a=="多→汉"?{src:"AUTO",res:"zh-CN"}:a=="多→日"?{src:"AUTO",res:"ja"}:a=="多→韩"?{src:"AUTO",res:"ko"}:a=="多→俄"?{src:"AUTO",res:"ru"}:a=="多→法"?{src:"AUTO",res:"fr"}:a=="多→西"?{src:"AUTO",res:"es"}:a=="多→德"?{src:"AUTO",res:"de"}:a=="多→意"?{src:"AUTO",res:"it"}:a=="多→马"?{src:"AUTO",res:"ms"}:a=="多→越"?{src:"AUTO",res:"ms"}:a=="多→瑞"?{src:"AUTO",res:"sv"}:a=="多→泰"?{src:"AUTO",res:"ta"}:a=="汉→粤"?{src:"zh",res:"yue"}:a=="粤→汉"?{src:"yue",res:"zh"}:a=="多→菲"?{src:"AUTO",res:"tl"}:{src:"AUTO",res:"zh-CN"}};