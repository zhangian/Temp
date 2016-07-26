package com.zdmoney.laocaibao.controller;

import com.zdmoney.laocaibao.common.dto.HttpResultDto;
import com.zdmoney.laocaibao.common.utils.EncryptUtil;
import com.zdmoney.laocaibao.common.utils.SessionUtils;
import com.zdmoney.laocaibao.dto.user.UserDto;
import com.zdmoney.laocaibao.net.LcbClientProxy;
import com.zdmoney.laocaibao.vo.RegisterUserVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.TreeMap;

@Controller
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    private LcbClientProxy clientProxy;

    @RequestMapping("/notRegistered")
    @ResponseBody
    public HttpResultDto isPhoneNotRegistered(String cellphone) throws IOException {
        TreeMap<String, Object> parameters = new TreeMap<>();
        parameters.put("cellphone", cellphone);
        return clientProxy.isPhoneNotRegistered(parameters);
    }

    @RequestMapping("/checkIntroduceCode")
    @ResponseBody
    public HttpResultDto checkIntroduceCode(String cmIntroduceCode) throws IOException {
        TreeMap<String, Object> parameters = new TreeMap<>();
        parameters.put("cmIntroduceCode", cmIntroduceCode);
        return clientProxy.checkIntroduceCode(parameters);
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView step1() throws IOException {
        return new ModelAndView("/registerStep1");
    }

    @RequestMapping(value = "/step2", method = RequestMethod.POST)
    public ModelAndView step2(RegisterUserVO registerUserVO, HttpServletRequest request) throws IOException {
        ModelAndView modelAndView = new ModelAndView("/registerStep2");
        modelAndView.addObject("registerUserVO", registerUserVO);
        return modelAndView;
    }

    @RequestMapping(value = "/step3", method = RequestMethod.POST)
    public ModelAndView step3(RegisterUserVO registerUserVO, HttpServletRequest request) throws IOException, NoSuchAlgorithmException {
        TreeMap<String, Object> parameters = new TreeMap<>();
        parameters.clear();
        parameters.put("cmCellphone", StringUtils.trimToEmpty(registerUserVO.getCmCellphone()));
        parameters.put("cmPassword", EncryptUtil.md5(StringUtils.trimToEmpty(registerUserVO.getCmPassword())));
        parameters.put("deviceId", request.getSession().getId());
        HttpResultDto<UserDto> loginResult = clientProxy.login(parameters);
        SessionUtils.setSessionUser(request, loginResult.getData());
        return new ModelAndView("/registerStep3");
    }

    @RequestMapping(value = "/registerStep1", method = RequestMethod.POST)
    @ResponseBody
    public HttpResultDto registerStep1(RegisterUserVO registerUserVO, HttpServletRequest request) throws IOException {
        HttpResultDto resultDto = registerUserVO.validate(SessionUtils.getImageCaptcha(request), clientProxy);
        return resultDto;
    }

    @RequestMapping(value = "/registerStep2", method = RequestMethod.POST)
    @ResponseBody
    public HttpResultDto registerStep2(RegisterUserVO registerUserVO, HttpServletRequest request) throws IOException, NoSuchAlgorithmException {
        if (StringUtils.isEmpty(registerUserVO.getValidateCode())) {
            return HttpResultDto.FAIL("请输入验证码");
        }
        TreeMap<String, Object> parameters = new TreeMap<>();
        String cmCellphone = StringUtils.substring(registerUserVO.getCmCellphone(), 0, 11);
        registerUserVO.setCmCellphone(cmCellphone);
        request.getSession().setAttribute("registerUserVO", registerUserVO);
        parameters.put("cmCellphone", StringUtils.trimToEmpty(cmCellphone));
        parameters.put("cmPassword", EncryptUtil.md5(StringUtils.trimToEmpty(registerUserVO.getCmPassword())));
        parameters.put("validateCode", StringUtils.trimToEmpty(registerUserVO.getValidateCode()));
        parameters.put("cmIntroduceCode", StringUtils.trimToEmpty(registerUserVO.getCmIntroduceCode()));
        parameters.put("redNo", StringUtils.trimToEmpty(registerUserVO.getRedNo()));
        HttpResultDto resultDto = clientProxy.register(parameters);
        SessionUtils.clearImageCaptcha(request);
        return resultDto;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView spiderRegister() throws IOException {
        return new ModelAndView("/spiderRegister");
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public HttpResultDto spiderRegister(RegisterUserVO registerUserVO) throws IOException {
        return HttpResultDto.SUCCESS("");
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView spiderRegisterSuccess() throws IOException {
        return new ModelAndView("/spiderRegisterSuccess");
    }





    @RequestMapping(value = "/spiderSuccess")
    public String spiderSuccess() {
        return "/spider/spiderSuccess";
    }


    @RequestMapping(value = "/spider", method = RequestMethod.GET)
    @ResponseBody
    public String spider(String name, int age) {
//        JSONObject json = new JSONObject();
//        json.put("text1","text1");
        BusiProductVO product3 = new BusiProductVO();
        String json = JSONObject.toJSON(product3).toString();
        return "spider/spider";
    }


}
