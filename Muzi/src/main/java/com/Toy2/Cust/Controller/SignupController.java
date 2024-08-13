package com.Toy2.Cust.Controller;

import com.Toy2.Cust.Dao.CustDao;
import com.Toy2.Cust.Domain.CustDto;
import com.Toy2.Cust.Service.CustService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping("/signup")
public class SignupController {
    @Autowired
    CustDao custDao;
    @Autowired
    CustService custService;

    @GetMapping("/add")
    public String signup(){
        return "registerForm";
    }

    @GetMapping("/mailCheck")
    @ResponseBody
    public String mailCheck(String email, HttpServletRequest request) {
        try{
            System.out.println("[dev]이메일 인증 요청이 들어옴!");
            System.out.println("[dev]이메일 인증 이메일 : " + email + "[dev]이메일 END==");

            String verificationCode = custService.joinEmail(email); // 이메일로 인증번호 발송
            System.out.println("[dev]자바로 받아온 인증번호:  " + verificationCode);

            HttpSession session = request.getSession();
            session.setAttribute("verificationCode", verificationCode); // 세션에 인증번호 저장
            System.out.println("[dev]검증용 저장 인증번호: " + session.getAttribute("verificationCode"));

            return verificationCode;
        } catch (Exception e) {
            return "errorPageC";
        }
    }

    @PostMapping("/add")
    public String signup(@ModelAttribute @Valid CustDto custDto,
                         BindingResult result, Model m, HttpServletRequest request){

        try {
            if(result.hasErrors()){
                System.out.println(result);
                return "registerForm";
            }

            HttpSession session = request.getSession();
            /* 이메일 인증번호 전송된것과 고객이 입력한것과 비교해서 일치하면 회원가입 */

            System.out.println("회원정보: " + custDto);

            custDao.insert(custDto);

        }catch (Exception e){
            e.printStackTrace();
        }
        return "redirect:/login";
    }
    @PostMapping("/email-check")
    public @ResponseBody String emailCheck(@RequestParam("c_email") String c_email) {
        try {
            String checkResult = custService.emailCheck(c_email);
            return checkResult;
        } catch (Exception e) {
            // 예외 처리 로직
            return "Invalid email address";
        }
    }

}
