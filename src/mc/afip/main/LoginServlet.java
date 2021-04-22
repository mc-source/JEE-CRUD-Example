package mc.afip.main;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import mc.afip.model.CartLine;
import mc.afip.model.User;
import mc.afip.model.UserRepository;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger("Login Servlet");

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		logger.info("logout.."+action);

		if(action.equals("logout")) {
			HttpSession session = request.getSession();
			session.setAttribute("user", null);


			session.setAttribute("cart", new ArrayList<CartLine>());


			response.sendRedirect("./main"); //Redirection vers url '/main' (==> Appel Sevlet MainServlet)
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
		if(action.equals("login")) {

			String login = request.getParameter("login");
			String password = request.getParameter("password");

			UserRepository repository = new UserRepository();
			User connected = repository.log(login, password);	

			//Gestion de la Session!
			HttpSession session = request.getSession();
			session.setAttribute("user", connected);

			if(connected!=null) {			
				response.sendRedirect("./main?page=welcome"); //Redirection vers AUTRE Servlet!
			}else {
				response.sendRedirect("./main");
			}
		}else {
			//signup!
			String prenom = request.getParameter("prenom");
			String nom = request.getParameter("nom");
			String login = request.getParameter("login");
			String password = request.getParameter("password");
			String password2 = request.getParameter("password2");
			
			if(password.equals(password2)) {
				UserRepository repository = new UserRepository();
				repository.add(new User(0, prenom, nom, login, password));
				response.sendRedirect("./main");
			}
		}
	}

}
