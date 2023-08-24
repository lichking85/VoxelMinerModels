using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class GameData : MonoBehaviour
{
    public static GameData I;

    [Header("FIELD DATA")]
    public float timeBetweenReceivingCollectibles;
    public float collectingHeight;
    public float collectingRotationSpeed;
    public float receiveObjectTime;

    [Header("Voxel Object Data")] 
    public float miniVoxelSize;
    public float timeToReceiveVoxel;
    public float timeBetweenReceivingVoxels;

    void Awake() {
        if (I == null) {
            I = this;
        }
    }
}
