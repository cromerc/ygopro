--Infernity Des Gunman
function c511000035.initial_effect(c)
	--Negate Damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000035,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511000035.con)
	e1:SetCost(c511000035.cost)
	e1:SetOperation(c511000035.op)
	c:RegisterEffect(e1)
end
function c511000035.con(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	if not ex then return false end
	if cp~=PLAYER_ALL then return Duel.IsPlayerAffectedByEffect(cp,EFFECT_REVERSE_RECOVER)
	else return Duel.IsPlayerAffectedByEffect(0,EFFECT_REVERSE_RECOVER)
		or Duel.IsPlayerAffectedByEffect(1,EFFECT_REVERSE_RECOVER)
	end
end
function c511000035.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511000035.op(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511000035.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 then
		if Duel.SelectYesNo(1-tp,aux.Stringid(511000035,REASON_EFFECT)) then
			Duel.ConfirmDecktop(tp,1)
			local g=Duel.GetDecktopGroup(tp,1)
			local tc=g:GetFirst()
			if tc:IsType(TYPE_MONSTER) then
				Duel.Damage(tp,2000,REASON_EFFECT)
				Duel.ShuffleDeck(tp,REASON_EFFECT)
			else
				Duel.Damage(1-tp,2000,REASON_EFFECT)
				Duel.ShuffleDeck(tp,REASON_EFFECT)
			end
		end
	end
end
function c511000035.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then return 0
	else return val end
end
