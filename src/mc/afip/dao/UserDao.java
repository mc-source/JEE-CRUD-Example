package mc.afip.dao;

import javax.persistence.TypedQuery;

import mc.afip.model.User;

public class UserDao extends Dao<User> {

	public UserDao() {
		super(User.class, "User");
	}

	//méthodes spécifiques
	public User log(String login, String password){		
		TypedQuery<User> query = 
				getEntityManager().createQuery("SELECT u FROM User u WHERE u.login=:login AND u.password=:password", User.class);
		query.setParameter("login", login);
		query.setParameter("password", password);

		try {
			return query.getSingleResult();
		} catch (Exception e) {
			return null;
		}	
	}


	//	//nom unité de persistence dans 'META-INF/persistence.xml'
	//	private static final String PERSISTENCE_UNIT_NAME = "region20website_pu";	
	//	private static EntityManager em=null;
	//	
	//	public UserDao() {
	//		if(em==null) {
	//			EntityManagerFactory emfactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);			
	//			em = emfactory.createEntityManager();
	//		}
	//	}
	//	
	//	//pour tests!
	//	public EntityManager getEntityManager() {
	//		return em;
	//	}
	//	
	//	
	//	/**
	//	 * CRUD (Opérations)
	//	 */
	//	public List<User> list(){		
	//		// TypedQuery<User> query = em.createQuery("SELECT u FROM User u ORDER BY u.nom", User.class);
	//	
	//		TypedQuery<User> query = em.createNamedQuery("User.findAll", User.class);		
	//		return query.getResultList();
	//	}
	//	public User find(int id){		
	//		// TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.id=:id", User.class);
	//	
	//		TypedQuery<User> query = em.createNamedQuery("User.find", User.class);		
	//		query.setParameter("id", id);
	//		
	//		return query.getSingleResult();
	//	}
	//	
	//	public User log(String login, String password){		
	//		TypedQuery<User> query = 
	//				em.createQuery("SELECT u FROM User u WHERE u.login=:login AND u.password=:password", User.class);
	//		query.setParameter("login", login);
	//		query.setParameter("password", password);
	//		
	//		try {
	//			return query.getSingleResult();
	//		} catch (Exception e) {
	//			return null;
	//		}	
	//	}
	//	
	//	public void delete(User item) {
	//		em.getTransaction().begin();
	//		em.remove(item);
	//		em.getTransaction().commit();
	//	}
	//	public void delete(int id) {
	//		User item = find(id);
	//		if(item!=null)
	//			delete(item);
	//	}
	//	public void update(User item) {
	//		em.getTransaction().begin();
	//		em.merge(item);
	//		em.getTransaction().commit();
	//	}
	//	public void add(User item) {
	//		em.getTransaction().begin();
	//		em.persist(item);
	//		em.getTransaction().commit();
	//	}
}
