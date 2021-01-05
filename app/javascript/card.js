const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵.環境変数を呼び出す
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault(); //通常のRuby on Railsにおけるフォーム送信処理はキャンセルされています。
    
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("card_number"),
      cvc: formData.get("card_cvc"),
      exp_month: formData.get("card_exp_month"),
      exp_year: `20${formData.get("card_exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        //valueは実際に送られる値、nameはその値を示すプロパティ名（params[:name]のように取得できるようになる）
        //type属性でトークンの値をブラウザ上で非表示にしましょう
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        //debugger; 処理が停止
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);
