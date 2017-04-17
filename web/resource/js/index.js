/*
使用示例：
<head>
	<script src="city.js" type="text/javascript"></script>
</head>
<body>
	<script>
		var add = new AddressCom();
		var add = new AddressCom('suffix'); //自定义input后缀,方便页面同时多处使用
		//add.set_init(["广东", "广州", "天河区"]); //初始值
		//add.set_init(["360000", "360700", "360726"]);//初始值
		//add.getvals();  //获得值
		//add.set_change(function(data){console.log(data);}); //change事件
	</script>
</body>
*/
var AddressCom = function(suffix){
	suffix = (suffix!=undefined?'_'+suffix:'');
	var address_level_info = [],address_level_codes = [];
	//address_level_codes=["360000", "360700", "360726"];
	//address_level_info =["广东", "广州", "天河区"];
	var rand_id = (Math.random()*(999999-100000)+100000).toString().split('\.')[0];
	var onchange = function(data){},is_user_click=true;
	
	function eare(){
		 $.ajax({  
			type:"GET",  
			url:"http://www.lpaiche.com/Index/address?level=0",  
			dataType: "jsonp",  
			success: function(res){  
				$.each(res.data,function(i,item){  
					$(".arer-sheng_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
				})  
				sheng_sel();

				$.each(res.data,function(i,item){  
					if(item.city_code == address_level_codes[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})
				
			    $.each(res.data,function(i,item){  
					if(item.city_name == address_level_info[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})
			}  
		}) 
	 
		function sheng_sel(){
			$(".arer-sheng_"+rand_id+" ul li").each(function(){
				$(this).click(function(event){
					if(is_user_click){
						address_level_info=[];			
					 	address_level_codes=[];	
					}
					 address_level_info[0]=$(this).html();
					 address_level_codes[0]=$(this).attr('code');
					 onchange(getvals());					 
					 var province=$(this).html();			 
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-shi_"+rand_id).show();
					 $(".arer-shi_"+rand_id+" ul").html("");
					 $.ajax({  
							type:"GET",  
							url:"http://www.lpaiche.com/Index/address?pid="+li_id, 
							cache:true, 
							dataType: "jsonp",  
							success: function(res){  
								$.each(res.data,function(i,item){
									$(".arer-shi_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});  
								shi_sel();
								if($(".arer-shi_"+rand_id+" ul li").length==1){
									$(".arer-shi_"+rand_id+" ul li").click();
									$(".arer-shi_"+rand_id).hide();
									return;
								}
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
								$.each(res.data,function(i,item){
									if(item.city_name == address_level_info[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
								
							}  
					  }) 
					  
				 })
		   })
			
		}	
		
		function shi_sel(){  
			 $(".arer-shi_"+rand_id+" ul li").each(function(){
				 var city=this;
				$(city).click(function(event){
					 address_level_info[1]=$(this).html();
					 address_level_codes[1]=$(this).attr('code');	
					 onchange(getvals());		 
					 //console.log($(city).html());
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-qu_"+rand_id+"").show();
					 $(".arer-qu_"+rand_id+" ul").html("");
					 var zhixiashi = ['北京','上海','天津','重庆'];				    
				    $(".city .area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]);	
					 $.ajax({  
							type:"GET",  
							url:"http://www.lpaiche.com/Index/address?pid="+li_id, 
							cache:true, 
							dataType: "jsonp",  
							success: function(res){  
								$.each(res.data,function(i,item){
									$(".arer-qu_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});  
								qu_sel();
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							   $.each(res.data,function(i,item){
									if(item.city_name == address_level_info[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							}  
					  })  
				 })
		   })
		}		
		function qu_sel(){ 
			 $(".arer-qu_"+rand_id+" ul li").click(function(){
				   address_level_info[2]=$(this).html()
				   address_level_codes[2]=$(this).attr('code');
				   onchange(getvals());
				   $(this).parent().parent().hide();
				   var zhixiashi = ['北京','上海','天津','重庆'];				    
				   $(".area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]+"-"+address_level_info[2]);	

				   var vals = [],data=getvals();								
				    $.each(data,function(i,n){ 
						vals.push(i);
					});
					var adds = [$('#province_'+rand_id+''),$('#city_'+rand_id+''),$('#area_'+rand_id+'')];
					$.each(adds,function(i,n){
						adds[i].val(vals[i]);
					})

			 })
		}
	}
	
	$(function(){
		$(".area_"+rand_id+" input").click(function(event){
			$(".arer-sheng_"+rand_id ).show();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id).hide();
			event.stopPropagation();
		});
		$("body").click(function(){
			$(".arer-sheng_"+rand_id ).hide();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id+"").hide();
		});	
		eare();
	});
	
	
	function getvals(){
						var ret = {};
						for(var i in address_level_codes){
							ret[address_level_codes[i]] = address_level_info[i];
						}
						return ret;
				 	};
	function getarr(){
					var ret = [];
						for(var i in address_level_codes){
							ret.push({code:address_level_codes[i],name:address_level_info[i]});
						}
						return ret;
	};
	this.getarr = getarr;
	this.getvals = getvals;
	this.set_init=function(init_vals){
					 if(typeof(init_vals[0])==undefined)
						return ;

					 if(parseInt(init_vals[0])>0){
						address_level_codes = init_vals;
					 }else{
						address_level_info = init_vals;
					 }

				 };	
	this.set_change=function(change){
		onchange=change;
	}

	function init_html(){
		var html='<input type="hidden" id="province_'+rand_id+'"  name="province'+suffix+'" value="" />'+
					'<input type="hidden" id="city_'+rand_id+'"  name="city'+suffix+'" value="" />'+
					'<input type="hidden" id="area_'+rand_id+'"  name="area'+suffix+'" value="" />'
		    html+='<div class="'+'area_'+rand_id+' area">'+'<span>起点：</span>'+
		 	'<input type="text" placeholder="请输入起点" class="boarding_point1"/>'+
		 	'<div class="arer-sheng_'+rand_id+' arer-sheng"><ul></ul></div>'+
		 	'<div class="arer-shi_'+rand_id+' arer-shi" ><ul></ul></div>'+
		 	'<div class="arer-qu_'+rand_id+' arer-qu"><ul></ul></div></div>';
		 return html;
	};
	document.write(init_html());
};
var AddressCom01 = function(suffix){
	suffix = (suffix!=undefined?'_'+suffix:'');
	var address_level_info = [],address_level_codes = [];
	//address_level_codes=["360000", "360700", "360726"];
	//address_level_info =["广东", "广州", "天河区"];
	var rand_id = (Math.random()*(999999-100000)+100000).toString().split('\.')[0];
	var onchange = function(data){},is_user_click=true;

	function eare(){
		 $.ajax({
			type:"GET",
			url:"http://www.lpaiche.com/Index/address?level=0",
			dataType: "jsonp",
			success: function(res){
				$.each(res.data,function(i,item){
					$(".arer-sheng_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
				})
				sheng_sel();

				$.each(res.data,function(i,item){
					if(item.city_code == address_level_codes[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})

			    $.each(res.data,function(i,item){
					if(item.city_name == address_level_info[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})
			}
		})

		function sheng_sel(){
			$(".arer-sheng_"+rand_id+" ul li").each(function(){
				$(this).click(function(event){
					if(is_user_click){
						address_level_info=[];
					 	address_level_codes=[];
					}
					 address_level_info[0]=$(this).html();
					 address_level_codes[0]=$(this).attr('code');
					 onchange(getvals());
					 var province=$(this).html();
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-shi_"+rand_id).show();
					 $(".arer-shi_"+rand_id+" ul").html("");
					 $.ajax({
							type:"GET",
							url:"http://www.lpaiche.com/Index/address?pid="+li_id,
							cache:true,
							dataType: "jsonp",
							success: function(res){
								$.each(res.data,function(i,item){
									$(".arer-shi_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});
								shi_sel();
								if($(".arer-shi_"+rand_id+" ul li").length==1){
									$(".arer-shi_"+rand_id+" ul li").click();
									$(".arer-shi_"+rand_id).hide();
									return;
								}
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
								$.each(res.data,function(i,item){
									if(item.city_name == address_level_info[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});

							}
					  })

				 })
		   })

		}

		function shi_sel(){
			 $(".arer-shi_"+rand_id+" ul li").each(function(){
				 var city=this;
				$(city).click(function(event){
					 address_level_info[1]=$(this).html();
					 address_level_codes[1]=$(this).attr('code');
					 onchange(getvals());
					 //console.log($(city).html());
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-qu_"+rand_id+"").show();
					 $(".arer-qu_"+rand_id+" ul").html("");
					 var zhixiashi = ['北京','上海','天津','重庆'];
				    $(".city .area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]);
					 $.ajax({
							type:"GET",
							url:"http://www.lpaiche.com/Index/address?pid="+li_id,
							cache:true,
							dataType: "jsonp",
							success: function(res){
								$.each(res.data,function(i,item){
									$(".arer-qu_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});
								qu_sel();
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							   $.each(res.data,function(i,item){
									if(item.city_name == address_level_info[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							}
					  })
				 })
		   })
		}
		function qu_sel(){
			 $(".arer-qu_"+rand_id+" ul li").click(function(){
				   address_level_info[2]=$(this).html()
				   address_level_codes[2]=$(this).attr('code');
				   onchange(getvals());
				   $(this).parent().parent().hide();
				   var zhixiashi = ['北京','上海','天津','重庆'];
				   $(".area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]+"-"+address_level_info[2]);

				   var vals = [],data=getvals();
				    $.each(data,function(i,n){
						vals.push(i);
					});
					var adds = [$('#province_'+rand_id+''),$('#city_'+rand_id+''),$('#area_'+rand_id+'')];
					$.each(adds,function(i,n){
						adds[i].val(vals[i]);
					})

			 })
		}
	}

	$(function(){
		$(".area_"+rand_id+" input").click(function(event){
			$(".arer-sheng_"+rand_id ).show();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id).hide();
			event.stopPropagation();
		});
		$("body").click(function(){
			$(".arer-sheng_"+rand_id ).hide();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id+"").hide();
		});
		eare();
	});


	function getvals(){
						var ret = {};
						for(var i in address_level_codes){
							ret[address_level_codes[i]] = address_level_info[i];
						}
						return ret;
				 	};
	function getarr(){
					var ret = [];
						for(var i in address_level_codes){
							ret.push({code:address_level_codes[i],name:address_level_info[i]});
						}
						return ret;
	};
	this.getarr = getarr;
	this.getvals = getvals;
	this.set_init=function(init_vals){
					 if(typeof(init_vals[0])==undefined)
						return ;

					 if(parseInt(init_vals[0])>0){
						address_level_codes = init_vals;
					 }else{
						address_level_info = init_vals;
					 }

				 };
	this.set_change=function(change){
		onchange=change;
	}

	function init_html(){
		var html='<input type="hidden" id="province_'+rand_id+'"  name="province'+suffix+'" value="" />'+
					'<input type="hidden" id="city_'+rand_id+'"  name="city'+suffix+'" value="" />'+
					'<input type="hidden" id="area_'+rand_id+'"  name="area'+suffix+'" value="" />'
		    html+='<div class="'+'area_'+rand_id+' area">'+'<span>终点：</span>'+
		 	'<input type="text" placeholder="请输入终点" class="breakout_point1"/>'+
		 	'<div class="arer-sheng_'+rand_id+' arer-sheng"><ul></ul></div>'+
		 	'<div class="arer-shi_'+rand_id+' arer-shi" ><ul></ul></div>'+
		 	'<div class="arer-qu_'+rand_id+' arer-qu"><ul></ul></div></div>';
		 return html;
	};
	document.write(init_html());
};
var AddressCom03 = function(suffix){
	suffix = (suffix!=undefined?'_'+suffix:'');
	var address_level_info = [],address_level_codes = [];
	//address_level_codes=["360000", "360700", "360726"];
	//address_level_info =["广东", "广州", "天河区"];
	var rand_id = (Math.random()*(999999-100000)+100000).toString().split('\.')[0];
	var onchange = function(data){},is_user_click=true;

	function eare(){
		 $.ajax({
			type:"GET",
			url:"http://www.lpaiche.com/Index/address?level=0",
			dataType: "jsonp",
			success: function(res){
				$.each(res.data,function(i,item){
					$(".arer-sheng_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
				})
				sheng_sel();

				$.each(res.data,function(i,item){
					if(item.city_code == address_level_codes[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})

			    $.each(res.data,function(i,item){
					if(item.city_name == address_level_info[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})
			}
		})

		function sheng_sel(){
			$(".arer-sheng_"+rand_id+" ul li").each(function(){
				$(this).click(function(event){
					if(is_user_click){
						address_level_info=[];
					 	address_level_codes=[];
					}
					 address_level_info[0]=$(this).html();
					 address_level_codes[0]=$(this).attr('code');
					 onchange(getvals());
					 var province=$(this).html();
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-shi_"+rand_id).show();
					 $(".arer-shi_"+rand_id+" ul").html("");
					 $.ajax({
							type:"GET",
							url:"http://www.lpaiche.com/Index/address?pid="+li_id,
							cache:true,
							dataType: "jsonp",
							success: function(res){
								$.each(res.data,function(i,item){
									$(".arer-shi_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});
								shi_sel();
								if($(".arer-shi_"+rand_id+" ul li").length==1){
									$(".arer-shi_"+rand_id+" ul li").click();
									$(".arer-shi_"+rand_id).hide();
									return;
								}
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
								$.each(res.data,function(i,item){
									if(item.city_name == address_level_info[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});

							}
					  })

				 })
		   })

		}

		function shi_sel(){
			 $(".arer-shi_"+rand_id+" ul li").each(function(){
				 var city=this;
				$(city).click(function(event){
					 address_level_info[1]=$(this).html();
					 address_level_codes[1]=$(this).attr('code');
					 onchange(getvals());
					 //console.log($(city).html());
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-qu_"+rand_id+"").show();
					 $(".arer-qu_"+rand_id+" ul").html("");
					 var zhixiashi = ['北京','上海','天津','重庆'];
				    $(".city .area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]);
					 $.ajax({
							type:"GET",
							url:"http://www.lpaiche.com/Index/address?pid="+li_id,
							cache:true,
							dataType: "jsonp",
							success: function(res){
								$.each(res.data,function(i,item){
									$(".arer-qu_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});
								qu_sel();
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							   $.each(res.data,function(i,item){
									if(item.city_name == address_level_info[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							}
					  })
				 })
		   })
		}
		function qu_sel(){
			 $(".arer-qu_"+rand_id+" ul li").click(function(){
				   address_level_info[2]=$(this).html()
				   address_level_codes[2]=$(this).attr('code');
				   onchange(getvals());
				   $(this).parent().parent().hide();
				   var zhixiashi = ['北京','上海','天津','重庆'];
				   $(".area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]+"-"+address_level_info[2]);

				   var vals = [],data=getvals();
				    $.each(data,function(i,n){
						vals.push(i);
					});
					var adds = [$('#province_'+rand_id+''),$('#city_'+rand_id+''),$('#area_'+rand_id+'')];
					$.each(adds,function(i,n){
						adds[i].val(vals[i]);
					})

			 })
		}
	}

	$(function(){
		$(".area_"+rand_id+" input").click(function(event){
			$(".arer-sheng_"+rand_id ).show();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id).hide();
			event.stopPropagation();
		});
		$("body").click(function(){
			$(".arer-sheng_"+rand_id ).hide();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id+"").hide();
		});
		eare();
	});


	function getvals(){
						var ret = {};
						for(var i in address_level_codes){
							ret[address_level_codes[i]] = address_level_info[i];
						}
						return ret;
				 	};
	function getarr(){
					var ret = [];
						for(var i in address_level_codes){
							ret.push({code:address_level_codes[i],name:address_level_info[i]});
						}
						return ret;
	};
	this.getarr = getarr;
	this.getvals = getvals;
	this.set_init=function(init_vals){
					 if(typeof(init_vals[0])==undefined)
						return ;

					 if(parseInt(init_vals[0])>0){
						address_level_codes = init_vals;
					 }else{
						address_level_info = init_vals;
					 }

				 };
	this.set_change=function(change){
		onchange=change;
	}

	function init_html(){
		var html='<input type="hidden" id="province_'+rand_id+'"  name="province'+suffix+'" value="" />'+
					'<input type="hidden" id="city_'+rand_id+'"  name="city'+suffix+'" value="" />'+
					'<input type="hidden" id="area_'+rand_id+'"  name="area'+suffix+'" value="" />'
		    html+='<div class="'+'area_'+rand_id+' area">'+'<span>起点：</span>'+
		 	'<input type="text" placeholder="请输入起点" class="boarding_point"/>'+
		 	'<div class="arer-sheng_'+rand_id+' arer-sheng"><ul></ul></div>'+
		 	'<div class="arer-shi_'+rand_id+' arer-shi" ><ul></ul></div>'+
		 	'<div class="arer-qu_'+rand_id+' arer-qu"><ul></ul></div></div>';
		 return html;
	};
	document.write(init_html());
};
var AddressCom04 = function(suffix){
	suffix = (suffix!=undefined?'_'+suffix:'');
	var address_level_info = [],address_level_codes = [];
	//address_level_codes=["360000", "360700", "360726"];
	//address_level_info =["广东", "广州", "天河区"];
	var rand_id = (Math.random()*(999999-100000)+100000).toString().split('\.')[0];
	var onchange = function(data){},is_user_click=true;

	function eare(){
		 $.ajax({
			type:"GET",
			url:"http://www.lpaiche.com/Index/address?level=0",
			dataType: "jsonp",
			success: function(res){
				$.each(res.data,function(i,item){
					$(".arer-sheng_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
				})
				sheng_sel();

				$.each(res.data,function(i,item){
					if(item.city_code == address_level_codes[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})

			    $.each(res.data,function(i,item){
					if(item.city_name == address_level_info[0]) {
						is_user_click = false;
						$(".arer-sheng_"+rand_id+" ul li").eq(i).click();
						is_user_click = true;
						return;
					}
				})
			}
		})

		function sheng_sel(){
			$(".arer-sheng_"+rand_id+" ul li").each(function(){
				$(this).click(function(event){
					if(is_user_click){
						address_level_info=[];
					 	address_level_codes=[];
					}
					 address_level_info[0]=$(this).html();
					 address_level_codes[0]=$(this).attr('code');
					 onchange(getvals());
					 var province=$(this).html();
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-shi_"+rand_id).show();
					 $(".arer-shi_"+rand_id+" ul").html("");
					 $.ajax({
							type:"GET",
							url:"http://www.lpaiche.com/Index/address?pid="+li_id,
							cache:true,
							dataType: "jsonp",
							success: function(res){
								$.each(res.data,function(i,item){
									$(".arer-shi_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});
								shi_sel();
								if($(".arer-shi_"+rand_id+" ul li").length==1){
									$(".arer-shi_"+rand_id+" ul li").click();
									$(".arer-shi_"+rand_id).hide();
									return;
								}
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
								$.each(res.data,function(i,item){
									if(item.city_name == address_level_info[1]) {
										$(".arer-shi_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});

							}
					  })

				 })
		   })

		}

		function shi_sel(){
			 $(".arer-shi_"+rand_id+" ul li").each(function(){
				 var city=this;
				$(city).click(function(event){
					 address_level_info[1]=$(this).html();
					 address_level_codes[1]=$(this).attr('code');
					 onchange(getvals());
					 //console.log($(city).html());
					 event.stopPropagation();
					 var li_id = $(this).attr("code");
					 $(this).parent().parent().hide();
					 $(".arer-qu_"+rand_id+"").show();
					 $(".arer-qu_"+rand_id+" ul").html("");
					 var zhixiashi = ['北京','上海','天津','重庆'];
				    $(".city .area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]);
					 $.ajax({
							type:"GET",
							url:"http://www.lpaiche.com/Index/address?pid="+li_id,
							cache:true,
							dataType: "jsonp",
							success: function(res){
								$.each(res.data,function(i,item){
									$(".arer-qu_"+rand_id+" ul").append("<li code='"+item.city_code+"'>"+item.city_name+"</li>");
								});
								qu_sel();
								$.each(res.data,function(i,item){
									if(item.city_code == address_level_codes[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							   $.each(res.data,function(i,item){
									if(item.city_name == address_level_info[2]) {
										$(".arer-qu_"+rand_id+" ul li").eq(i).click();
										return;
									}
								});
							}
					  })
				 })
		   })
		}
		function qu_sel(){
			 $(".arer-qu_"+rand_id+" ul li").click(function(){
				   address_level_info[2]=$(this).html()
				   address_level_codes[2]=$(this).attr('code');
				   onchange(getvals());
				   $(this).parent().parent().hide();
				   var zhixiashi = ['北京','上海','天津','重庆'];
				   $(".area_"+rand_id+" input").val(($.inArray(address_level_info[0],zhixiashi)<0?address_level_info[0]+"-":'')+address_level_info[1]+"-"+address_level_info[2]);

				   var vals = [],data=getvals();
				    $.each(data,function(i,n){
						vals.push(i);
					});
					var adds = [$('#province_'+rand_id+''),$('#city_'+rand_id+''),$('#area_'+rand_id+'')];
					$.each(adds,function(i,n){
						adds[i].val(vals[i]);
					})

			 })
		}
	}

	$(function(){
		$(".area_"+rand_id+" input").click(function(event){
			$(".arer-sheng_"+rand_id ).show();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id).hide();
			event.stopPropagation();
		});
		$("body").click(function(){
			$(".arer-sheng_"+rand_id ).hide();
			$(".arer-shi_"+rand_id ).hide();
			$(".arer-qu_"+rand_id+"").hide();
		});
		eare();
	});


	function getvals(){
						var ret = {};
						for(var i in address_level_codes){
							ret[address_level_codes[i]] = address_level_info[i];
						}
						return ret;
				 	};
	function getarr(){
					var ret = [];
						for(var i in address_level_codes){
							ret.push({code:address_level_codes[i],name:address_level_info[i]});
						}
						return ret;
	};
	this.getarr = getarr;
	this.getvals = getvals;
	this.set_init=function(init_vals){
					 if(typeof(init_vals[0])==undefined)
						return ;

					 if(parseInt(init_vals[0])>0){
						address_level_codes = init_vals;
					 }else{
						address_level_info = init_vals;
					 }

				 };
	this.set_change=function(change){
		onchange=change;
	}

	function init_html(){
		var html='<input type="hidden" id="province_'+rand_id+'"  name="province'+suffix+'" value="" />'+
					'<input type="hidden" id="city_'+rand_id+'"  name="city'+suffix+'" value="" />'+
					'<input type="hidden" id="area_'+rand_id+'"  name="area'+suffix+'" value="" />'
		    html+='<div class="'+'area_'+rand_id+' area">'+'<span>终点：</span>'+
		 	'<input type="text" placeholder="请输入终点" class="breakout_point"/>'+
		 	'<div class="arer-sheng_'+rand_id+' arer-sheng"><ul></ul></div>'+
		 	'<div class="arer-shi_'+rand_id+' arer-shi" ><ul></ul></div>'+
		 	'<div class="arer-qu_'+rand_id+' arer-qu"><ul></ul></div></div>';
		 return html;
	};
	document.write(init_html());
};


