using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour
{
    [SerializeField]
    private GameObject waterParticle;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        //Mouse
        if (Input.GetMouseButtonDown(0))   {
            var tmpParticle = Instantiate(waterParticle);
            var mousePosScreenWorldPosition = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            tmpParticle.transform.position = new Vector3(mousePosScreenWorldPosition.x, mousePosScreenWorldPosition.y, -6);
        }
        //Touch screen
        if (Input.touchCount > 0)   {
            Touch touch = Input.GetTouch(0);
            var tmpParticle = Instantiate(waterParticle);
            tmpParticle.transform.position = new Vector3(touch.position.x, touch.position.y, -6);
        }
    }
}
