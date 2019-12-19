package com.publics.vo.sys;


import javax.persistence.*;

@Entity
@Table(name = "characters")
public class CharactersVo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int characterId;           /*主键，标识列，自动生成*/
    private String characterName;      /*角色名称*/
    private int postId;                /*关联岗位表,给岗位设置权限*/

    @Override
    public String toString() {
        return "CharactersVo{" +
                "characterId=" + characterId +
                ", characterName='" + characterName + '\'' +
                ", postId=" + postId +
                '}';
    }

    public int getCharacterId() {
        return characterId;
    }

    public void setCharacterId(int characterId) {
        this.characterId = characterId;
    }

    public String getCharacterName() {
        return characterName;
    }

    public void setCharacterName(String characterName) {
        this.characterName = characterName;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }
}
