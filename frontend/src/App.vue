<template>
  <div
    class="page"
  >
    <h1>WEB assistant</h1>
      <textarea
        v-model="question"
        class="m-0 w-full resize-none border-0 bg-transparent p-0 pr-10 focus:ring-0 focus-visible:ring-0 dark:bg-transparent md:pr-12 pl-3 md:pl-0"
        placeholder="Send a message."
        rows="1"
    />
    <button @click="sendQuestion">send</button>
    <div
      v-for="answer in listAnswers"
      :key="answer"
    >
    {{ answer }}
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      question: '',
      answer: '',
      listAnswers: [],
      api_url: 'http://localhost:3000/chats',
    }
  },
  methods: {
    async sendQuestion () {
      try {
        const response = await fetch(this.api_url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            question: this.question
          })
        })
        let dataAnswer = await response.json();
        this.answer = dataAnswer.answer;
        this.listAnswers.push(this.answer);
        this.question = '';
      } catch (error) {
        console.log('Send question', error);
      }
    }
  }
}
</script>
