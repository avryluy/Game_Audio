using UnityEngine;
using System;
using System.Collections.Generic;


// Place this on your player character if it is a third person view.
// This script will adapt the sound based on the camera movement instead of the character gameObject's actual Z-axis orientation.

public class ThirdPersonListener: MonoBehaviour {

    public GameObject RotationSource;

    void Start () {

    }

    void Update () {
        transform.rotation = RotationSource.transform.rotation;
    }

}
