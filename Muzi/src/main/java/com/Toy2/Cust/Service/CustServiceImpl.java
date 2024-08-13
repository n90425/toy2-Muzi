package com.Toy2.Cust.Service;

import com.Toy2.Cust.Dao.CustDao;
import com.Toy2.Cust.Domain.CustDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.util.Random;

@Service
public class CustServiceImpl implements CustService {
    @Autowired
    private  CustDao custDao;

    @Autowired
    private JavaMailSenderImpl mailSender;

    private int authNumber;


    @Override
    public String emailCheck(String c_email) throws Exception{
        CustDto custDto = custDao.selectEmail(c_email);
        if (custDto == null) {
            return "ok";
        }else {
            return "no";
        }
    }

    public  void makeRandomNumber() throws Exception{
        Random r = new Random();
        int checkNum = r.nextInt(888888) + 111111;
        System.out.println("인증번호 : " + checkNum);
        authNumber = checkNum;
    }

    public String joinEmail(String c_email) throws Exception{
        makeRandomNumber();
        String setFrom = ".com"; // email-config에 설정한 자신의 이메일 주소를 입력
        String toMail = c_email;
        String title = "WELCOME HOMERUN BALL :)"; // 이메일 제목
        String content = "고객님이 요청하신 인증번호는 " + authNumber + "입니다.";
        mailSend(setFrom, toMail, title, content);
        return Integer.toString(authNumber);
    }



    public void mailSend(String setFrom, String toMail, String title, String content) throws Exception{
        MimeMessage message = mailSender.createMimeMessage();
        // true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
//        try {
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
        helper.setFrom(setFrom);
        helper.setTo(toMail);
        helper.setSubject(title);
        // true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
        helper.setText(content, true);
        mailSender.send(message);
    }

}

