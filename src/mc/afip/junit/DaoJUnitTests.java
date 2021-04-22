package mc.afip.junit;

import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.persistence.EntityManager;

import org.junit.Test;

import mc.afip.dao.UserDao;
import mc.afip.model.User;

public class DaoJUnitTests {

	@Test
	public void test1() {
		//test unitaire
		UserDao dao = new UserDao();
		assertNotNull(dao); //test validé si dao non null!
		
		System.out.println(dao);
	}
	@Test
	public void test2() {
		//test unitaire
		UserDao dao = new UserDao();
		EntityManager em = dao.getEntityManager();
		assertNotNull(em);
		
		System.out.println(em);
	}
	@Test
	public void test3() {
		//test unitaire
		UserDao dao = new UserDao();
		List<User> users = dao.list();
		
		assertNotEquals(users.size(), 0);
		
		System.out.println(users);
	}
	@Test
	public void test4() {
		//test unitaire
		UserDao dao = new UserDao();
		dao.add(new User(0, "Bart","Simpson","donut","000"));

		assertNotNull(dao.find(4));
		
	}
	@Test
	public void test5() {
		//test unitaire
		UserDao dao = new UserDao();
		
		User u = dao.log("james","xxx");
		//assertNotNull(u);
		System.out.println(u);
		
	}
}
