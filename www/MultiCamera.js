var exec = require('cordova/exec');

var service = "MultiCamera";

exports.openCamera = function(success,error,params){
	console.log("MultiCamera.js... openCamera params: ",params);
	exec(success, error, service, 'openCamera', []);
};