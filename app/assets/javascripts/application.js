// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
/*global $*/

// $(document).on('turbolinks:load', () => {
//   $(function() {
//   	setTimeout(function(){
// 	  	$('.start p').fadeIn(600);  // pの表示スピード
//   	},500); //0.5秒後にロゴをフェードイン!
//   	setTimeout(function(){
// 	  	$('.start').fadeOut(1000);  // start自体の消えるスピード
//   	},2500); //2.5秒後にロゴ含め真っ白背景をフェードアウト！(状態維持時間)
//   });
// });

// 検索機能ーーーーーーーー＞
$(document).on('turbolinks:load', () => {
  $(function(){
    $("#search__form").on('ajax:success', function(event) {
        $("#result").html(event.detail[2].response);
    });
  });
});
// 検索機能ここまでーーーーーーーー＞
//ハンバーガー------------>
document.addEventListener("turbolinks:load", function () {
  $(function(){
    $('.menu-trigger').on('click',function(event){
      $(this).toggleClass('active');
      $('#sp-menu').fadeToggle();
      // event.PreventDefault();
    });
  });
});
// ハンバーガーここまで----------->

// Slickここから----------->
$(document).on('turbolinks:load', function(){
  $('.slider').slick({
    autoplay: true,//自動的に動き出すか。初期値はfalse。
    infinite: true,//スライドをループさせるかどうか。初期値はtrue。
    speed: 500,//スライドのスピード。初期値は300。
    slidesToShow: 3,//スライドを画面に3枚見せる
    slidesToScroll: 1,//1回のスクロールで1枚の写真を移動して見せる
    prevArrow: '<div class="slick-prev"></div>',//矢印部分PreviewのHTMLを変更
    nextArrow: '<div class="slick-next"></div>',//矢印部分NextのHTMLを変更
    centerMode: true,//要素を中央ぞろえにする
    variableWidth: true,//幅の違う画像の高さを揃えて表示
    dots: true,//下部ドットナビゲーションの表示
  });
});
// Slickここまで----------->
// 画像スライドここから----------->
$(document).on('turbolinks:load', function(){
  $(function(){
    $(window).scroll(function(){
      $(".scroll-block").each(function(){
        var scroll = $(window).scrollTop(); //画面トップからのスクロール量
        var blockPosition = $(this).offset().top; //画面トップから見たブロックのある位置
        var windowHeight = $(window).height(); //ウィンドウの高さ
        if (scroll > blockPosition - windowHeight + 260){
          $(this).addClass("blockIn");
        }
      });
    });
  });
});
// 画像スライドここまで----------->
// リップルズここから----------->
$(document).on('turbolinks:load', function(){
  $('.ripples-image').ripples({
    dropRadius: 20, //波紋の大きさ
    resolution: 500, //波紋の広がり速度
    perturbance: 0.001, //波紋のブレ
  });
});
$(document).on('turbolinks:load', function(){
  $('#rippler').ripples({
    dropRadius: 20, //波紋の大きさ
    resolution: 500, //波紋の広がり速度
    perturbance: 0.001, //波紋のブレ
  });
});
// リップルズここまで----------->
// タブメニューここから----------->

// タブメニューここまで----------->

