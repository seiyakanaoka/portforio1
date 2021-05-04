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
//= require bxslider
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', () => {
$(function() {
	setTimeout(function(){
		$('.start p').fadeIn(600);  // pの表示スピード
	},500); //0.5秒後にロゴをフェードイン!
	setTimeout(function(){
		$('.start').fadeOut(1000);  // start自体の消えるスピード
	},2500); //2.5秒後にロゴ含め真っ白背景をフェードアウト！(状態維持時間)
});
});

$(document).on('turbolinks:load', () => {
  $('.bxslider').bxSlider({
    auto: true,           // 自動スライド
    speed: 1000,          // スライドするスピード
    moveSlides: 1,        // 移動するスライド数
    pause: 3000,          // 自動スライドの待ち時間
    maxSlides: 4,         // 一度に表示させる最大数
    slideWidth: 250,      // 各スライドの幅
	randomStart: true,    // 最初に表示するスライドをランダムに設定
    autoHover: true,       // ホバー時に自動スライドを停止
    controls: true,
    pager: false,
    prevText:'＜',
		nextText:'＞',
  });
});
