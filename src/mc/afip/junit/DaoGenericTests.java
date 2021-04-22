package mc.afip.junit;

import static org.junit.Assert.assertNotNull;

import java.math.BigDecimal;
import java.util.List;

import org.junit.Test;

import mc.afip.dao.Dao;
import mc.afip.model.Article;
import mc.afip.model.User;

public class DaoGenericTests {

	@Test
	public void test1() {
		Dao<User> dao = new Dao<>(User.class, "User");
		List<User> items =  dao.list();
		
		assertNotNull(items);
		
		for (User item : items) {
			System.out.println(item);
		}
	}
	@Test
	public void test2() {
		Dao<Article> dao = new Dao<>(Article.class, "Article");
		
		dao.add(new Article(0, "PC DELL 2500", "", 259.99f));
		dao.add(new Article(0, "Imprimante EPSON 2510", "", 99.99f));
		
		List<Article> items =  dao.list();
		
		assertNotNull(items);

		for (Article item : items) {
			System.out.println(item);
		}
	}

}
