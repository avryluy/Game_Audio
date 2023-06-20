using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerCharacterAudio_TEMP : MonoBehaviour
{
    [Header("Wwise")]
    [SerializeField]
    public AK.Wwise.Event footStepLeft;
    public AK.Wwise.Event footStepRight;
    public AK.Wwise.Event attack;
    public AK.Wwise.Event damaged;
    public AK.Wwise.Event death;

    // Start is called before the first frame update
    void Start()
    {
        AkSoundEngine.RegisterGameObj(gameObject);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void playerStepLeft()
    {
        footStepLeft.Post(gameObject);
    }

    void playerStepRight()
    {
        footStepRight.Post(gameObject);
    }

    void player_attack()
    {
        attack.Post(gameObject);
    }

        void player_hurt()
    {
        damaged.Post(gameObject);
    }

        void player_death()
    {
        death.Post(gameObject);
    }

}
