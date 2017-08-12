using System.Collections;
using UnityEngine.UI;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour {

	public float speed = 15;
	public Text countText;
	public Text winText;
	private Rigidbody rb;
	private int count;

	void Start()
	{
		rb = GetComponent<Rigidbody> ();
		count = 0;
		CountText ();
		winText.text = "";
	}

	void Update() 
	{
		if (Input.GetKey (KeyCode.Escape)) 
		{
			Application.Quit();
		}
	}

	void FixedUpdate()
	{
		float moveHorizontal = Input.GetAxis ("Horizontal");
		float moveVertical = Input.GetAxis ("Vertical");

		Vector3 movement = new Vector3 (moveHorizontal, 0.0f, moveVertical);
		rb.AddForce (movement * speed);
	}

	void OnTriggerEnter(Collider other) 
	{
		if (other.gameObject.CompareTag ("pickUps"))
		{
			other.gameObject.SetActive (false);
			count = count + 1;
			CountText ();
		}
	}
	void CountText()
	{
		countText.text = "Count:" + count.ToString ();
		if (count >= 12)
		{
			winText.text = "You Won !!";
		}
	}
}