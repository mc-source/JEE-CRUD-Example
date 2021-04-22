package mc.afip.main;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Tests {

	public void test() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
		LocalDateTime.now().format(formatter);
	}
}
