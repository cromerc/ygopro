--Gagaga Thunder
--  By Shad3
--fixed by MLD
function c511005080.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511005080.target)
	e1:SetOperation(c511005080.activate)
	c:RegisterEffect(e1)
end
function c511005080.filter1(c,tp)
	return c:GetLevel()>0 and c:IsSetCard(0x54) 
		and Duel.IsExistingTarget(c511005080.filter2,tp,LOCATION_MZONE,0,1,c,c:GetLevel())
end
function c511005080.filter2(c,lv)
	return c:GetLevel()>0 and c:GetLevel()~=lv and c:IsSetCard(0x54)
end
function c511005080.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511005080.filter1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc1=Duel.SelectTarget(tp,c511005080.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc2=Duel.SelectTarget(tp,c511005080.filter2,tp,LOCATION_MZONE,0,1,1,tc1,tc1:GetLevel()):GetFirst()
	local lv=0
	if tc1:GetLevel()>tc2:GetLevel() then
		lv=tc1:GetLevel()-tc2:GetLevel()
	else
		lv=tc2:GetLevel()-tc1:GetLevel()
	end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,lv*300)
end
function c511005080.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==2 then
		local tc1=g:GetFirst()
		local tc2=g:GetNext()
		local lv=0
		if tc1:GetLevel()>tc2:GetLevel() then
			lv=tc1:GetLevel()-tc2:GetLevel()
		else
			lv=tc2:GetLevel()-tc1:GetLevel()
		end
		Duel.Damage(1-tp,lv*300,REASON_EFFECT)
	end
end
