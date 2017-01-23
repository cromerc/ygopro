--アルカナフォースＶＩＩＩ－ＳＴＲＥＮＧＴＨ
function c100000105.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000105,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c100000105.cointg)
	e1:SetOperation(c100000105.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c100000105.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c100000105.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local res=0
	if c:IsHasEffect(73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else res=Duel.TossCoin(tp,1) end
	local g
	if res==0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONTROL)
		g=Duel.SelectMatchingCard(1-tp,Card.IsControlerCanBeChanged,1-tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		g=Duel.SelectMatchingCard(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)			
	end
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.GetControl(tc,1-tc:GetControler())
	end
end
