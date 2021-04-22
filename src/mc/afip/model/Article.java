package mc.afip.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the articles database table.
 * 
 */
@Entity
@Table(name="articles")
@NamedQueries({
	@NamedQuery(name="Article.findAll", query="SELECT a FROM Article a"),
	@NamedQuery(name="Article.find", query="SELECT a FROM Article a WHERE a.id=:id")
})

public class Article implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String nom;

	private String photo;

	private float prix;
	
	private String descriptif;

	public Article() {
	}

	public Article(int id, String nom, String photo, float prix) {
		this( id,  nom,  photo,  prix,  "");
	}
	

	public Article(int id, String nom, String photo, float prix, String descriptif) {
		this.id = id;
		this.nom = nom;
		this.photo = photo;
		this.prix = prix;
		this.descriptif = descriptif;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public float getPrix() {
		return this.prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}
	
	

	public String getDescriptif() {
		return descriptif;
	}

	public void setDescriptif(String descriptif) {
		this.descriptif = descriptif;
	}

	@Override
	public String toString() {
		return "[" + id + ", nom=" + nom + ", photo=" + photo + ", prix=" + prix + "]";
	}

}