package hello.servlet.basic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "helloServlet", urlPatterns = "/hello")
public class HelloServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("HelloServlet.service");
        System.out.println("request = " + request);
        System.out.println("response = " + response);

        // 쿼리파라미터 꺼내기
        String username = request.getParameter("username");
        System.out.println(username);

        // 헤더정보
        response.setContentType("text/plain");
        response.setCharacterEncoding("utf-8");

        // 바디에 값을 작성
        response.getWriter().write("hello " + username);
    }

}
