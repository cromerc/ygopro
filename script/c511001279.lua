--Fluffal Wing
function c511001279.initial_effect(c)
	--banish, draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511001279.con)
	e1:SetTarget(c511001279.tg)
	e1:SetOperation(c511001279.op)
	c:RegisterEffect(e1)
end
function c511001279.cfilter(c)
	return c:IsFaceup() and c:IsCode(70245411)
end
function c511001279.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001279.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511001279.filter(c)
	return c:IsCode(72413000) and c:IsAbleToRemove()
end
function c511001279.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511001279.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001279.filter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511001279.filter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,0,0)
end
function c511001279.trfilter(c)
	return c:IsReleasableByEffect() and c:IsCode(70245411)
end
function c511001279.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:FilterCount(Card.IsRelateToEffect,nil,e)==2 then
		if Duel.Remove(g,POS_FACEUP,REASON_EFFECT) then
			Duel.BreakEffect()
			if Duel.Draw(tp,2,REASON_EFFECT) and Duel.IsPlayerCanDraw(tp,1) 
				and Duel.IsExistingMatchingCard(c511001279.trfilter,tp,LOCATION_ONFIELD,0,1,nil) 
				and Duel.SelectYesNo(tp,aux.Stringid(90434926,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
				local tr=Duel.SelectMatchingCard(tp,c511001279.trfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
				if tr:GetCount()>0 and Duel.Release(tr,REASON_EFFECT)~=0 then
					Duel.Draw(tp,1,REASON_EFFECT)
				end
			end
		end
	end
end
