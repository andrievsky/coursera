define(["jquery","js/lib/modals","js/lib/cookie","js/lib/data.attributes","spark/app/signature/js/general_sigtrack_modal","js/lib/util"],function($,Modal,Cookie,DataAttributes,SignatureModal,util){$(function(){if(0===$("[data-doing_well_signup_url]").length)return;if(util.isMobileDevice())return;var signupUrl=$("[data-doing_well_signup_url]").attr("data-doing_well_signup_url"),m=new SignatureModal($(".coursera-signature-doing-well-modal"));m.setDoingWell(signupUrl),m.open()})});