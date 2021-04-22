package mc.afip.main;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import mc.afip.model.Article;
import mc.afip.model.ArticlesRepository;
import mc.afip.model.CartLine;

/**
 * Servlet implementation class MainServlet
 */
@WebServlet(	urlPatterns = { "/main"}, 
initParams = { @WebInitParam(name = "copyright", value = "mc@2020", description = "copyright..")})

//@MultipartConfig( fileSizeThreshold = 1024 * 1024, 
//				  maxFileSize = 1024 * 1024 * 5,
//				  maxRequestSize = 1024 * 1024 * 5 * 5 )

public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger("Main Servlet");

	private static final String VIEW_DIR ="views/";
	private static final String VIEW_SUFFIX =".jsp";

	private static final String DEFAULT_VIEW = "index"+VIEW_SUFFIX;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String page = request.getParameter("page"); //récuperer paramètre d'URL
		logger.info("MainServlet : Appel doGet - page = "+page);	

		request.setAttribute("page", page);
		String view_name = (page==null)?DEFAULT_VIEW:VIEW_DIR+page.toLowerCase()+VIEW_SUFFIX;	

		if(view_exists(view_name)) {
			getViewModel(request, page); //Associer Event. Données (Model) à la vue!

			display(request, response, view_name);
		}else {
			display(request, response, VIEW_DIR+"404"+VIEW_SUFFIX);
		}	
	}
	private void getViewModel(HttpServletRequest request,  String page) {
		if(page==null)
			return;

		/**
		 * Gestion 'Articles' (CRUD)
		 */
		if(page.equalsIgnoreCase("articles")) {

			String action = request.getParameter("action");
			ArticlesRepository repository = new ArticlesRepository();

			request.setAttribute("action", action);

			/**
			 * Session : Panier!
			 */
			HttpSession session = request.getSession();
			if(session.getAttribute("cart")==null) {
				session.setAttribute("cart", new ArrayList<CartLine>());
			}

			List<CartLine> panier = (ArrayList<CartLine>) session.getAttribute("cart");

			if(action==null) {			
				//				List<Article> items = repository.list();    //récuprerer data (liste articles) du repository				
				//				request.setAttribute("items", items); 		//envoi data (items) à la vue!
				paginate(request); //envoi data avec pagination!!

			}else if(action.equalsIgnoreCase("cart")) {
				paginate(request);			
			}else if(action.equalsIgnoreCase("edit") || action.equalsIgnoreCase("delete")) {
				try {
					int id = Integer.parseInt(request.getParameter("id"));
					Article item = repository.find(id);

					request.getSession().setAttribute("item", item);
					//request.setAttribute("item", item);
				} catch (Exception e) {
					logger.error("MainServlet : Error = "+e);		
				}
			}else if(action.equalsIgnoreCase("add")) {
				
				if(request.getSession().getAttribute("item")==null)
					request.getSession().setAttribute("item", new Article());
				
				//equest.getSession().setAttribute("newItem", new Article());
				//request.setAttribute("item", new Article());
			}else if(action.equalsIgnoreCase("detail")) {
				try {
					
					int id = Integer.parseInt(request.getParameter("id"));
					Article item = repository.find(id);

					request.setAttribute("item", item);
				} catch (Exception e) {
					logger.error("MainServlet : Error = "+e);		
				}
			}
		}	
	}
	private boolean view_exists(String view_name) {
		String view_fullpath = getServletContext().getRealPath(view_name);	
		try {			
			File view_file = new File(view_fullpath);
			return view_file.exists();		 
		} catch (Exception e) {}
		return false;
	}

	private void display(HttpServletRequest request, HttpServletResponse response, String view_name) {
		RequestDispatcher dispatcher = request.getRequestDispatcher(view_name); //..définition page
		try {
			dispatcher.forward(request, response); //..rediriger vers page	
		} catch (ServletException | IOException e) {
			logger.error("MainServlet - Error : "+e);
		} 	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("MainServlet : Appel doPost!");

		String action = request.getParameter("action");
		request.setAttribute("action", action);

		if(action==null) {
			display(request, response, VIEW_DIR+"welcome"+VIEW_SUFFIX);
			return;
		}

		ArticlesRepository repository = new ArticlesRepository();
		if(action.equalsIgnoreCase("delete")) {
			try {
				logger.info("action delete!");

				int id = Integer.parseInt(request.getParameter("id"));
				Article item = repository.find(id);

				if(item!=null)
					repository.delete(item);

				PrepareList(request, response, repository);	

			} catch (Exception e) {
				logger.info("action delete ==> Error : "+e);
				display(request, response, VIEW_DIR+"error"+VIEW_SUFFIX);
			}

		}else if(action.equalsIgnoreCase("add")) {

			try {
				logger.info("action add!");

				Article item = new Article(0, 
						request.getParameter("nom"), 
						request.getParameter("photo"),
						Float.parseFloat(request.getParameter("prix").replace(",",".")),
						request.getParameter("descriptif")
						);

				repository.add(item);

				request.getSession().setAttribute("item", new Article());
				PrepareList(request, response, repository);		

			} catch (Exception e) {
				logger.info("action add ==> Error : "+e);				
				display(request, response, VIEW_DIR+"error"+VIEW_SUFFIX);
			}

		}else if(action.equalsIgnoreCase("edit")) {
			try {
				logger.info("action edit : "+request.getParameter("id"));

				Article item = new Article(Integer.parseInt(request.getParameter("id")), 
						request.getParameter("nom"), 
						request.getParameter("photo"),
						Float.parseFloat(request.getParameter("prix").replace(",",".")),
						request.getParameter("descriptif")
						);


				repository.update(item);
				request.getSession().setAttribute("item", new Article());
				
				PrepareList(request, response, repository);	

			} catch (Exception e) {
				logger.info("action update ==> Error : "+e);				
				display(request, response, VIEW_DIR+"error"+VIEW_SUFFIX);
			}

		}else if(action.equalsIgnoreCase("cart")) {
			try {
				logger.info("action cart add!");

				int id = Integer.parseInt(request.getParameter("id"));

				List<CartLine> cart = (List<CartLine>) request.getSession().getAttribute("cart");

				//article existe ds panier?
				int index_in_cart = -1;
				for (CartLine cartLine : cart) { //parcours lignes panier
					if(cartLine.getId()==id) {						
						index_in_cart = cart.indexOf(cartLine);
						break;
					}
				}

				if(index_in_cart == -1) {
					//ajouter nouvel article dans panier
					Article article = repository.find(id);			
					CartLine item = new CartLine(id, article.getNom(), 1, article.getPrix());
					cart.add(item);
				}else {
					//augmenter quantité article EXISTANT dans panier
					cart.get(index_in_cart).setQuantity(cart.get(index_in_cart).getQuantity()+1);
				}

				request.getSession().setAttribute("cart", cart);

				PrepareList(request, response, repository);	

			} catch (Exception e) {
				logger.info("action add ==> Error : "+e);				
				display(request, response, VIEW_DIR+"error"+VIEW_SUFFIX);
			}

		}else if(action.equalsIgnoreCase("cart-delete")) {
			try {
				logger.info("action cart delete!");

				int id = Integer.parseInt(request.getParameter("id"));

				List<CartLine> cart = (List<CartLine>) request.getSession().getAttribute("cart");

				//article existe ds panier?
				int index_in_cart = -1;
				for (CartLine cartLine : cart) {
					if(cartLine.getId()==id) {						
						index_in_cart = cart.indexOf(cartLine);
						break;
					}
				}
				if(index_in_cart != -1)
					cart.remove(index_in_cart);

				request.getSession().setAttribute("cart", cart);


				PrepareList(request, response, repository);	

			} catch (Exception e) {
				logger.info("action add ==> Error : "+e);				
				display(request, response, VIEW_DIR+"error"+VIEW_SUFFIX);
			}

		}
		//		else {
		//			display(request, response, VIEW_DIR+"welcome"+VIEW_SUFFIX);
		//		}

	}

	private void PrepareList(HttpServletRequest request, HttpServletResponse response, ArticlesRepository repository) throws IOException {
		List<Article> items = repository.list(); 				
		request.setAttribute("items", items); 							
		response.sendRedirect("./main?page=articles");	
	}


	static int items_by_page_count = 3;
	static int current_page = 1;
	int pages_count = 0;	

	private void paginate(HttpServletRequest request) {		
		ArticlesRepository repository = new ArticlesRepository();
		List<Article> items = repository.list();				

		int items_count = items.size();		
		pages_count = (items_count / items_by_page_count) + ((items_count % items_by_page_count)>0?1:0);

		int num_page =1;
		try {
			num_page = Integer.parseInt(request.getParameter("n"));
		} catch (Exception e) {}

		if(num_page>=1 && num_page<=pages_count)
			current_page=num_page;


		int index_last = current_page * items_by_page_count;
		int index_first = index_last - items_by_page_count;


		if(items_count<index_last)
			index_last = items_count;

		logger.info("********************************");	
		logger.info("Pagination ==> pages count : "+pages_count);	
		logger.info("Pagination ==> current page : "+current_page);	
		logger.info("Pagination ==> index : "+index_first+" - "+index_last);	
		logger.info("********************************");

		request.setAttribute("current_page", current_page); 
		request.setAttribute("pages_count", pages_count); 
		request.setAttribute("items_count", items_count);

		request.setAttribute("items", items.subList(index_first, index_last)); 
	}


}
