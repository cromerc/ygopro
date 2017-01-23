--Ma'at (Anime)
function c511000508.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,57116033,47297616,true,true)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000508,0))
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511000508.target)
	e1:SetOperation(c511000508.operation)
	e1:SetLabel(0)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetLabelObject(e1)
	e2:SetValue(c511000508.value)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e3)
end
function c511000508.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511000508.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local g=Duel.GetDecktopGroup(tp,1)
		Duel.Hint(HINT_SELECTMSG,tp,564)
		local ac=Duel.AnnounceCard(tp)
		if Duel.Draw(p,d,REASON_EFFECT)>0 then
			Duel.ConfirmCards(1-tp,g:GetFirst())
			if g:GetFirst():GetCode()==ac then
				e:SetLabel(e:GetLabel()+1)
				e:SetCountLimit(1)
			end
		end
	end
end
function c511000508.value(e,c)
	return e:GetLabelObject():GetLabel()*1000
end
