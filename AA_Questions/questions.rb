require 'sqlite3'
require 'singleton'

class QuestionsDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Users
  attr_accessor  :fname, :lname

  def self.find_by_id(id)
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil unless user.length > 0
    Users.new(user.first)
  end

  def self.find_by_name(fname,lname)
    user = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?
        AND
        lname = ?
    SQL
    return nil unless user.length > 0
    user.map { |this_user| Users.new(this_user) }
  end

  def initialize(options)
    @fname = options['fname']
    @lname = options['lname']
  end
end



class Questions
  attr_accessor  :title, :body, :author_id

  def self.find_by_id(id)
    question = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    return nil unless question.length > 0
    Questions.new(question.first)
  end

  def self.find_by_title(question)
    question = QuestionsDBConnection.instance.execute(<<-SQL, question)
      SELECT
        *
      FROM
        questions
      WHERE
        question = ?
    SQL
    return nil unless question.length > 0
    question.map { |this_question| Questions.new(this_question) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
end



class QuestionFollows
  attr_accessor  :questions_id, :users_id

  def self.find_by_id(id)
    question_follow = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    return nil unless question_follow.length > 0
    QuestionFollows.new(question_follows.first)
  end
end



class Replies
  attr_accessor :body, :questions_id, :parent_reply_id, :user_id

  def self.find_by_id(id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil unless reply.length > 0
    Replies.new(reply.first)
  end

  def find_by_author(user_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    return nil unless reply.length > 0
    Replies.new(reply.first)
  end

  def initialize (options)
    @id = options['id']
    @body = options['body']
    @questions_id = options['questions_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id = options['user_id']
  end
end



class QuestionLikes
  attr_accessor :likes, :questions_id, :user_id

  def self.find_by_id(id)
    like = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        likes
      WHERE
        id = ?
    SQL
    return nil unless like.length > 0
    Likes.new(like.first)
  end
end
