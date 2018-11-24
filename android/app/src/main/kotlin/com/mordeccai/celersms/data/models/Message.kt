package com.mordeccai.celersms.data.models


import android.arch.persistence.room.*

@Entity(tableName = "messages")
data class Message(
        @PrimaryKey(autoGenerate = true)
        var id: Int? = null,
        var address: String = "",
        var body: String = "",
        var dateSent: Long = 0,
        var date: Long = 0,
        var read: Int=0,
        var threadId: Long = 0,
        var serviceCenter: String = "",
        var synced: Int = 0,
        var uuid: Int=0
)

@Dao
interface MessageDao {
    @Insert
    fun insert(message: Message)

    @Update
    fun update(message: Message)

    @Delete
    fun delete(message: Message)

    @Query("DELETE FROM messages")
    fun deleteAll()

    @Query("SELECT * FROM messages")
    fun findAll(): List<Message>

    @Query("SELECT * FROM messages WHERE id =:id")
    fun findMessageById(id: Int): List<Message>

    @Query("SELECT * FROM messages WHERE address =:address")
    fun findMessageByAddress(address: String): List<Message>

    @Query("SELECT * FROM messages WHERE synced =:synced")
    fun findMessageBySynced(synced: Int): List<Message>

    @Insert
    fun insertAll(vararg message: Message)
}