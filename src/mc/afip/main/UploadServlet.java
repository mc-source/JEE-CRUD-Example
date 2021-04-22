package mc.afip.main;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.log4j.Logger;

import mc.afip.model.Article;


@WebServlet("/upload")
@MultipartConfig( 	fileSizeThreshold = 1024 * 1024, 
maxFileSize = 1024 * 1024 * 5,
maxRequestSize = 1024 * 1024 * 5 * 5 )

public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger("Upload Servlet");

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	public static final String IMAGES_FOLDER = "/assets/photos";    
	public String uploadPath;

	int article_id=0;
	String action, article_name="", article_photo="";
	float article_price=0f;

	@Override
	public void init() throws ServletException {
		logger.info("init..");

		uploadPath = getServletContext().getRealPath( IMAGES_FOLDER );
		logger.info("init..uploadPath = "+uploadPath);

		File uploadDir = new File( uploadPath );
		logger.info("init..uploadDir = "+uploadDir.getAbsolutePath());

		if (!uploadDir.exists()) uploadDir.mkdir();
	}
	private String getFileName( Part part ) {
		String fileName="";
		String param_value;
		
		String[] tokens = part.getHeader("content-disposition" ).split( ";" ) ;

		logger.info("========================================");
		logger.info("tokens  : "+part.getHeader("content-disposition" ));
		logger.info("========================================");

		logger.info("========================================");
		for (String token : tokens) {
			logger.info("token  : "+token);

			if (token.trim().startsWith("filename")) {
				fileName = token.substring(token.indexOf("=") + 2, token.length()-1);
				
				File uploadedFile = new File(fileName);
				fileName = uploadedFile.getName();
				
			}else  if (token.trim().startsWith("name")) {
				param_value = token.substring(token.indexOf("=") + 2, token.length()-1);

				logger.info("param_value : "+param_value);

				if(param_value.startsWith("action:")) 
					action = param_value.replace("action:", "");
				
				if(param_value.startsWith("id:")) 
					article_id = Integer.parseInt(param_value.replace("id:", ""));
				if(param_value.startsWith("name:")) 
					article_name = param_value.replace("name:", "");
				if(param_value.startsWith("price:")) 
					article_price = Float.parseFloat(param_value.replace("price:", ""));
			}

		}
		logger.info(action+" : "+article_name + " ==> "+article_price);
		
		logger.info("========================================");
		
		return fileName;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/**
		 * Upload file
		 */
		logger.info("**********************************************");
		String fileName="";
		try {
			for ( Part part : request.getParts() ) {

				fileName = getFileName( part );		
				if(!"".equals(fileName)) {
					String fullPath = uploadPath + File.separator + fileName;
					part.write( fullPath );

					logger.info("========================================");
					logger.info("file  '"+fullPath+"' uploaded with success!");
					logger.info("========================================");
					
					article_photo = fileName;
				}
			}

			if(request.getSession().getAttribute("item")==null)
				request.getSession().setAttribute("item", new Article());

			Article item = (Article) request.getSession().getAttribute("item");	
			
			item.setId(article_id);			
			item.setNom(article_name);
			item.setPhoto(article_photo);			
			item.setPrix(article_price);
			
			request.getSession().setAttribute("item", item);		
			
			logger.info("========================================");
			logger.info("saved item : "+item);
			logger.info("========================================");
			
			String url_param_id = action.equals("edit")?"&id="+article_id:"";
			response.sendRedirect(request.getContextPath()+"/main?page=articles&action="+action+url_param_id);

		} catch (Exception e) {
			logger.info("Upload file ==> Error : "+e);				
			e.printStackTrace();
		}
		logger.info("**********************************************");
	}

}
