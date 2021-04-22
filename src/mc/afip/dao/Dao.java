package mc.afip.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

public class Dao<T> {
	private static final String PERSISTENCE_UNIT_NAME = "region20website_pu";	
	private static EntityManager em=null;

	Class<?> entityClass;
	String entityName;
	public Dao(Class<?> entityClass, String entityName) {
		this.entityClass = entityClass;
		this.entityName = entityName;
		
		if(em==null) {
			EntityManagerFactory emfactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);			
			em = emfactory.createEntityManager();
		}
	}	
	//pour tests!
	public EntityManager getEntityManager() {
		return em;
	}

	/**
	 * CRUD (Opérations)
	 */
	@SuppressWarnings("unchecked")
	public List<T> list(){		
		TypedQuery<T> query = (TypedQuery<T>) em.createNamedQuery(entityName+".findAll", entityClass);		
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public T find(int id){		
		TypedQuery<T> query = (TypedQuery<T>) em.createNamedQuery(entityName+".find", entityClass);		
		query.setParameter("id", id);
		return query.getSingleResult();
	}

	public void delete(T item) {
		em.getTransaction().begin();
		em.remove(item);
		em.getTransaction().commit();
	}
	public void delete(int id) {
		T item = find(id);
		if(item!=null)
			delete(item);
	}
	public void update(T item) {
		em.getTransaction().begin();
		em.merge(item);
		em.getTransaction().commit();
	}
	public void add(T item) {
		em.getTransaction().begin();
		em.persist(item);
		em.getTransaction().commit();
	}
	
	
	
}
