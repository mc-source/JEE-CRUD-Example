package mc.afip.model;

import mc.afip.dao.ArticleDao;

public class ArticlesRepository extends ArticleDao {
	
//	private static final Logger logger = Logger.getLogger("Repository");
//
//	private static List<Article> items = new ArrayList<Article>( 
//			Arrays.asList(			
//					new Article(0, "Souris Logitech Wireless", 12.49, ""),
//					new Article(0, "Tapis Souris StarWars", 7.99, ""),
//					new Article(0, "PC Lifebook A Series", 499.99, ""),	
//					new Article(0, "Imprimante EPSON WF-2510", 99.49, ""),
//					new Article(0, "TV LG 4k 47pc", 320.99, ""),
//					new Article(0, "PC LENOVO 2020", 499.99, ""),
//					new Article(0, "Souris Microsoft Wireless", 12.49, ""),
//					new Article(0, "Tapis Souris Google", 7.99, ""),
//					new Article(0, "PC DELL 2019", 499.99, "")	
//				)
//			);
//
//	//	public int getFreeId() {
//	//		Stream<Article> s = items.stream();		
//	//		Optional<Article> max_article = s.max(Comparator.comparing(i->i.getId()));
//	//		return  max_article.isPresent()?max_article.get().getId()+1:1;	
//	//	}
//
//	public List<Article> list(){
//		return items;
//	}
//
//	public Article find(int id) {
//		for (Article article : items) {
//			if(article.getId()==id)
//				return article;
//		}
//		return null;
//	}
//
//	public void create(Article item) {
//		items.add(item);
//	}
//	public void create(int id, String nom, double prix, String photo) {
//		create(new Article(id, nom, prix, photo));
//	}
//
//	public void update(Article item) {
//		for (Article article : items) {
//
//			if(article.getId()==item.getId()) {
//				//article à modifier trouvé!
//
//				logger.info("update : "+article.getId());
//
//				article.setNom(item.getNom());
//				article.setPrix(item.getPrix());
//				article.setPhoto(item.getPhoto());
//
//				return;
//			}				
//		}
//	}
//	public void update(int id, String nom, double prix, String photo) {
//		update(new Article(id, nom, prix, photo));
//	}
//
//	public void delete(Article item) {
//		//int i = items.indexOf(item);
//		logger.info(".. item to delete = "+item);	
//		items.remove(item);
//	}
//	public void delete(int id) {
//		Article item = find(id);
//		if(item!=null)
//			delete(item);
//	}

}
