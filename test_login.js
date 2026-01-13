const axios = require('axios');
const crypto = require('crypto');

// 生成MD5哈希值
function md5(str) {
  return crypto.createHash('md5').update(str).digest('hex');
}

// 完整登录流程
async function testLogin() {
  try {
    console.log('1. 获取验证码...');
    // 获取验证码
    const captchaResponse = await axios.get('http://localhost:9999/jshERP-boot/user/randomImage');
    const uuid = captchaResponse.data.data.uuid;
    console.log('验证码UUID:', uuid);
    
    // 模拟验证码输入（实际登录时需要手动输入）
    const code = 'xxxx'; // 这里简化处理，实际需要输入正确的验证码
    
    console.log('2. 准备登录参数...');
    // 准备登录参数
    const loginParams = {
      loginName: 'jsh',
      password: md5('123456'), // 对密码进行MD5加密
      code: code,
      uuid: uuid
    };
    
    console.log('登录参数:', loginParams);
    
    console.log('3. 发送登录请求...');
    // 发送登录请求
    const loginResponse = await axios.post('http://localhost:9999/jshERP-boot/user/login', loginParams, {
      headers: {
        'Content-Type': 'application/json'
      }
    });
    
    console.log('登录响应:', JSON.stringify(loginResponse.data, null, 2));
    
    if (loginResponse.data.code === 200) {
      console.log('\n✅ 登录成功！');
      console.log('Token:', loginResponse.data.data.token);
    } else {
      console.log('\n❌ 登录失败！');
      console.log('错误信息:', loginResponse.data.data.message || loginResponse.data.message);
    }
    
  } catch (error) {
    console.error('\n❌ 登录过程出错:', error.message);
    if (error.response) {
      console.error('错误响应:', JSON.stringify(error.response.data, null, 2));
    }
  }
}

// 测试直接登录（不使用验证码，仅用于调试）
async function testDirectLogin() {
  try {
    console.log('\n--- 测试直接登录（无验证码）---');
    const loginParams = {
      loginName: 'jsh',
      password: '123456' // 直接使用明文密码
    };
    
    const loginResponse = await axios.post('http://localhost:9999/jshERP-boot/user/login', loginParams, {
      headers: {
        'Content-Type': 'application/json'
      }
    });
    
    console.log('直接登录响应:', JSON.stringify(loginResponse.data, null, 2));
    
  } catch (error) {
    console.error('直接登录出错:', error.message);
    if (error.response) {
      console.error('错误响应:', JSON.stringify(error.response.data, null, 2));
    }
  }
}

// 执行测试
testLogin().then(() => {
  testDirectLogin();
});
