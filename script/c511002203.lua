--機械竜 パワー・ツール
function c511002203.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetDescription(aux.Stringid(68084557,0))
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_EQUIP)
	e1:SetTarget(c511002203.drtg)
	e1:SetOperation(c511002203.drop)
	c:RegisterEffect(e1)
	--equip change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetDescription(aux.Stringid(68084557,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511002203.eqtg)
	e2:SetOperation(c511002203.eqop)
	c:RegisterEffect(e2)
end
function c511002203.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511002203.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c511002203.eqfilter(c,ec)
	return c:IsType(TYPE_EQUIP) and c:GetEquipTarget() and c:GetEquipTarget()~=ec
end
function c511002203.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002203.eqfilter,tp,0,LOCATION_SZONE,1,nil,e:GetHandler())
		and not e:GetHandler():IsStatus(STATUS_CHAINING) end
end
function c511002203.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(43641473,0))
	local g=Duel.SelectMatchingCard(tp,c511002203.eqfilter,tp,0,LOCATION_SZONE,1,5,nil,e:GetHandler())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		while tc do
			Duel.Equip(tp,tc,c)
			tc=g:GetNext()
		end
	end
end
