--Shining Horizon
--シャイニング・ホライゾン
--  By Shad3

local scard=c511005076

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetCondition(scard.cd)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local rc=tc:GetReasonCard()
	return tc:IsType(TYPE_MONSTER) and rc:IsRelateToBattle() and rc:IsControler(tp)
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local p,amt=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,amt,REASON_EFFECT)~=0 then
		local dc=Duel.GetOperatedGroup():GetFirst()
		Duel.ConfirmCards(1-p,dc)
		if dc:GetType()==TYPE_SPELL and Duel.GetLocationCount(p,LOCATION_SZONE)>0 then
			local te=dc:GetActivateEffect()
			if not te or te:GetCode()~=EVENT_FREE_CHAIN then return end
			local teprop=te:GetProperty()
			te:SetProperty(bit.bor(teprop,EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL))
			local res=false
			if te:IsActivatable(p) then res=true end
			te:SetProperty(teprop)
			if not res then return end
			local cond=te:GetCondition()
			local cost=te:GetCost()
			local targ=te:GetTarget()
			if (not cond or cond(te,p,eg,ep,ev,re,r,rp)) and
				(not cost or cost(te,p,eg,ep,ev,re,r,rp,0)) and
				(not targ or targ(te,p,eg,ep,ev,re,r,rp,0)) and
				Duel.SelectYesNo(p,aux.Stringid(4002,1)) then
				Duel.BreakEffect()
				local oper=te:GetOperation()
				Duel.ClearTargetCard()
				e:SetProperty(te:GetProperty())
				Duel.MoveToField(dc,p,p,LOCATION_SZONE,POS_FACEUP,true)
				Duel.Hint(HINT_CARD,0,dc:GetOriginalCode())
				dc:CreateEffectRelation(te)
				if cost then cost(te,p,eg,ep,ev,re,r,rp,1) end
				if targ then targ(te,p,eg,ep,ev,re,r,rp,1) end
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if g then
					local tgc=g:GetFirst()
					while tgc do
						tgc:CreateEffectRelation(te)
						tgc=g:GetNext()
					end
				end
				dc:SetStatus(STATUS_ACTIVATED,true)
				if oper then oper(te,p,eg,ep,ev,re,r,rp) end
				dc:ReleaseEffectRelation(te)
				if g then
					local tgc=g:GetFirst()
					while tgc do
						tgc:ReleaseEffectRelation(te)
						tgc=g:GetNext()
					end
				end
				dc:CancelToGrave(false)
			end
		else
			Duel.ShuffleHand(p)
		end
	end
end